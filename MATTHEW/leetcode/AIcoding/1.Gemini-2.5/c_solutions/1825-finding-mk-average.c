#include <stdlib.h>
#include <stdio.h> // For NULL, but not strictly needed for LeetCode submission

typedef struct AVLTreeNode {
    int val;
    int count; // Number of times this specific value appears
    struct AVLTreeNode *left;
    struct AVLTreeNode *right;
    int height;
    long long subtree_sum; // Sum of all values in the subtree, considering duplicates
    int subtree_size; // Total count of elements in the subtree, considering duplicates
} AVLTreeNode;

int avl_height(AVLTreeNode *node) {
    return node ? node->height : 0;
}

int avl_size(AVLTreeNode *node) {
    return node ? node->subtree_size : 0;
}

long long avl_sum(AVLTreeNode *node) {
    return node ? node->subtree_sum : 0LL;
}

void update_node_info(AVLTreeNode *node) {
    if (node) {
        node->height = 1 + (avl_height(node->left) > avl_height(node->right) ? avl_height(node->left) : avl_height(node->right));
        node->subtree_size = avl_size(node->left) + avl_size(node->right) + node->count;
        node->subtree_sum = avl_sum(node->left) + avl_sum(node->right) + (long long)node->val * node->count;
    }
}

AVLTreeNode* createNode(int val) {
    AVLTreeNode *newNode = (AVLTreeNode *)malloc(sizeof(AVLTreeNode));
    newNode->val = val;
    newNode->count = 1;
    newNode->left = NULL;
    newNode->right = NULL;
    newNode->height = 1;
    newNode->subtree_sum = val;
    newNode->subtree_size = 1;
    return newNode;
}

AVLTreeNode* rightRotate(AVLTreeNode *y) {
    AVLTreeNode *x = y->left;
    AVLTreeNode *T2 = x->right;

    x->right = y;
    y->left = T2;

    update_node_info(y);
    update_node_info(x);

    return x;
}

AVLTreeNode* leftRotate(AVLTreeNode *x) {
    AVLTreeNode *y = x->right;
    AVLTreeNode *T2 = y->left;

    y->left = x;
    x->right = T2;

    update_node_info(x);
    update_node_info(y);

    return y;
}

int getBalance(AVLTreeNode *node) {
    return node ? avl_height(node->left) - avl_height(node->right) : 0;
}

AVLTreeNode* avl_insert(AVLTreeNode *node, int val) {
    if (node == NULL) {
        return createNode(val);
    }

    if (val < node->val) {
        node->left = avl_insert(node->left, val);
    } else if (val > node->val) {
        node->right = avl_insert(node->right, val);
    } else { // val == node->val
        node->count++;
    }

    update_node_info(node);

    int balance = getBalance(node);

    // Left Left Case
    if (balance > 1 && val < node->left->val) {
        return rightRotate(node);
    }
    // Right Right Case
    if (balance < -1 && val > node->right->val) {
        return leftRotate(node);
    }
    // Left Right Case
    if (balance > 1 && val > node->left->val) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }
    // Right Left Case
    if (balance < -1 && val < node->right->val) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node;
}

AVLTreeNode* findMinNode(AVLTreeNode *node) {
    AVLTreeNode *current = node;
    while (current->left != NULL) {
        current = current->left;
    }
    return current;
}

AVLTreeNode* avl_delete(AVLTreeNode *root, int val) {
    if (root == NULL) {
        return root;
    }

    if (val < root->val) {
        root->left = avl_delete(root->left, val);
    } else if (val > root->val) {
        root->right = avl_delete(root->right, val);
    } else { // val == root->val
        if (root->count > 1) {
            root->count--;
        } else { // count == 1, delete the node
            if ((root->left == NULL) || (root->right == NULL)) {
                AVLTreeNode *temp = root->left ? root->left : root->right;
                if (temp == NULL) { // No child case
                    temp = root;
                    free(temp);
                    root = NULL;
                } else { // One child case
                    *root = *temp; // Copy contents of the child
                    free(temp);
                }
            } else { // Two children case
                AVLTreeNode *temp = findMinNode(root->right);
                root->val = temp->val;
                root->count = temp->count; // Copy count as well
                root->right = avl_delete(root->right, temp->val); // Delete the successor
            }
        }
    }

    if (root == NULL) {
        return root;
    }

    update_node_info(root);

    int balance = getBalance(root);

    // Left Left Case
    if (balance > 1 && getBalance(root->left) >= 0) {
        return rightRotate(root);
    }
    // Left Right Case
    if (balance > 1 && getBalance(root->left) < 0) {
        root->left = leftRotate(root->left);
        return rightRotate(root);
    }
    // Right Right Case
    if (balance < -1 && getBalance(root->right) <= 0) {
        return leftRotate(root);
    }
    // Right Left Case
    if (balance < -1 && getBalance(root->right) > 0) {
        root->right = rightRotate(root->right);
        return leftRotate(root);
    }

    return root;
}

int avl_get_kth_smallest(AVLTreeNode *node, int k) {
    if (node == NULL || k <= 0 || k > avl_size(node)) {
        return -1; // Or handle error appropriately
    }

    int left_size = avl_size(node->left);

    if (k <= left_size) {
        return avl_get_kth_smallest(node->left, k);
    } else if (k > left_size + node->count) {
        return avl_get_kth_smallest(node->right, k - left_size - node->count);
    } else { // k is within the current node's range
        return node->val;
    }
}

int avl_get_max(AVLTreeNode *node) {
    if (node == NULL) return -1; // Should not happen if tree is not empty
    while (node->right != NULL) {
        node = node->right;
    }
    return node->val;
}

int avl_get_min(AVLTreeNode *node) {
    if (node == NULL) return -1; // Should not happen if tree is not empty
    while (node->left != NULL) {
        node = node->left;
    }
    return node->val;
}

typedef struct {
    int m;
    int k;

    int *deque_arr;
    int head;
    int tail;
    int current_size;

    AVLTreeNode *left_root;
    AVLTreeNode *mid_root;
    AVLTreeNode *right_root;
} MKAverage;

void move_element(MKAverage *obj, AVLTreeNode **from_root_ptr, AVLTreeNode **to_root_ptr, int val);
void balance_partitions(MKAverage *obj);

MKAverage* mkAverageCreate(int m, int k) {
    MKAverage *obj = (MKAverage *)malloc(sizeof(MKAverage));
    obj->m = m;
    obj->k = k;

    obj->deque_arr = (int *)malloc(sizeof(int) * m);
    obj->head = 0;
    obj->tail = 0;
    obj->current_size = 0;

    obj->left_root = NULL;
    obj->mid_root = NULL;
    obj->right_root = NULL;

    return obj;
}

void move_element(MKAverage *obj, AVLTreeNode **from_root_ptr, AVLTreeNode **to_root_ptr, int val) {
    *from_root_ptr = avl_delete(*from_root_ptr, val);
    *to_root_ptr = avl_insert(*to_root_ptr, val);
}

void balance_partitions(MKAverage *obj) {
    // Phase 1: Ensure left_root has at most k elements
    while (avl_size(obj->left_root) > obj->k) {
        int val_to_move = avl_get_max(obj->left_root);
        move_element(obj, &obj->left_root, &obj->mid_root, val_to_move);
    }

    // Phase 2: Ensure mid_root has at most m - 2k elements
    while (avl_size(obj->mid_root) > (obj->m - 2 * obj->k)) {
        int val_to_move = avl_get_max(obj->mid_root);
        move_element(obj, &obj->mid_root, &obj->right_root, val_to_move);
    }

    // Phase 3: Ensure right_root has at most k elements
    while (avl_size(obj->right_root) > obj->k) {
        int val_to_move = avl_get_min(obj->right_root);
        move_element(obj, &obj->right_root, &obj->mid_root, val_to_move);
    }

    // Phase 4: Ensure left_root has at least k elements (pull from mid)
    while (avl_size(obj->left_root) < obj->k && avl_size(obj->mid_root) > 0) {
        int val_to_move = avl_get_min(obj->mid_root);
        move_element(obj, &obj->mid_root, &obj->left_root, val_to_move);
    }

    // Phase 5: Ensure mid_root has at least m - 2k elements (pull from left)
    while (avl_size(obj->mid_root) < (obj->m - 2 * obj->k) && avl_size(obj->left_root) > 0) {
        int val_to_move = avl_get_max(obj->left_root);
        move_element(obj, &obj->left_root, &obj->mid_root, val_to_move);
    }

    // Phase 6: Ensure mid_root has at least m - 2k elements (pull from right)
    while (avl_size(obj->mid_root) < (obj->m - 2 * obj->k) && avl_size(obj->right_root) > 0) {
        int val_to_move = avl_get_min(obj->right_root);
        move_element(obj, &obj->right_root, &obj->mid_root, val_to_move);
    }
}

void mkAverageAdd(MKAverage* obj, int num) {
    if (obj->current_size == obj->m) {
        int old_num = obj->deque_arr[obj->head];
        obj->head = (obj->head + 1) % obj->m;

        // Remove old_num from its respective BST
        if (old_num <= avl_get_max(obj->left_root)) {
            obj->left_root = avl_delete(obj->left_root, old_num);
        } else if (old_num >= avl_get_min(obj->right_root)) {
            obj->right_root = avl_delete(obj->right_root, old_num);
        } else {
            obj->mid_root = avl_delete(obj->mid_root, old_num);
        }
    } else {
        obj->current_size++;
    }

    // Add new_num to deque
    obj->deque_arr[obj->tail] = num;
    obj->tail = (obj->tail + 1) % obj->m;

    // Add new_num to one of the BSTs. Initially add to mid_root for simplicity, then balance.
    obj->mid_root = avl_insert(obj->mid_root, num);

    balance_partitions(obj);
}

int mkAverageCalculateMKAverage(MKAverage* obj) {
    if (obj->current_size < obj->m) {
        return -1;
    }

    return avl_sum(obj->mid_root) / (obj->m - 2 * obj->k);
}

void free_avl_tree(AVLTreeNode *node) {
    if (node == NULL) {
        return;
    }
    free_avl_tree(node->left);
    free_avl_tree(node->right);
    free(node);
}

void mkAverageFree(MKAverage* obj) {
    free(obj->deque_arr);
    free_avl_tree(obj->left_root);
    free_avl_tree(obj->mid_root);
    free_avl_tree(obj->right_root);
    free(obj);
}