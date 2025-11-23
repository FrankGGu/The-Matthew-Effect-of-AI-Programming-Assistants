typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    TreeNode** stack;
    int top;
} BSTIterator;

BSTIterator* bstIteratorCreate(TreeNode* root) {
    BSTIterator* iterator = (BSTIterator*)malloc(sizeof(BSTIterator));
    iterator->stack = (TreeNode**)malloc(1000 * sizeof(TreeNode*));
    iterator->top = -1;
    while (root) {
        iterator->stack[++(iterator->top)] = root;
        root = root->left;
    }
    return iterator;
}

int bstIteratorNext(BSTIterator* obj) {
    TreeNode* node = obj->stack[obj->top--];
    int result = node->val;
    node = node->right;
    while (node) {
        obj->stack[++(obj->top)] = node;
        node = node->left;
    }
    return result;
}

bool bstIteratorHasNext(BSTIterator* obj) {
    return obj->top != -1;
}

void bstIteratorFree(BSTIterator* obj) {
    free(obj->stack);
    free(obj);
}