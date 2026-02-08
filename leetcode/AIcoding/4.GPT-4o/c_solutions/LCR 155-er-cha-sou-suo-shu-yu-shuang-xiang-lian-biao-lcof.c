struct TreeNode* prev = NULL;
struct TreeNode* head = NULL;

void convert(struct TreeNode* node) {
    if (!node) return;
    convert(node->left);
    if (!head) {
        head = node;
    } else {
        node->left = prev;
        prev->right = node;
    }
    prev = node;
    convert(node->right);
}

struct TreeNode* treeToDoublyList(struct TreeNode* root) {
    if (!root) return NULL;
    convert(root);
    head->left = prev;
    prev->right = head;
    return head;
}