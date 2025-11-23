struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct ListNode {
    struct TreeNode *val;
    struct ListNode *next;
};

struct ListNode* add_to_list(struct ListNode* list, struct TreeNode* node) {
    struct ListNode* new_node = (struct ListNode*)malloc(sizeof(struct ListNode));
    new_node->val = node;
    new_node->next = list;
    return new_node;
}

struct ListNode* findDuplicateSubtrees(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }
    char map[10000][100];
    int count[10000] = {0};
    int index = 0;

    struct ListNode* result = NULL;

    void serialize(struct TreeNode* node) {
        if (!node) {
            return;
        }
        char buffer[100];
        sprintf(buffer, "%d,%d,", node->val, index);
        strcat(map[index], buffer);
        serialize(node->left);
        serialize(node->right);
        if (count[index] == 1) {
            result = add_to_list(result, node);
        }
        count[index]++;
        index++;
    }

    serialize(root);
    *returnSize = (result) ? 1 : 0;
    return result;
}