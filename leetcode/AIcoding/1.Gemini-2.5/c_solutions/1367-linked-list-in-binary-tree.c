#include <stdbool.h>
#include <stddef.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool checkPath(struct ListNode* head, struct TreeNode* root) {
    if (head == NULL) {
        return true;
    }
    if (root == NULL) {
        return false;
    }
    if (head->val != root->val) {
        return false;
    }
    return checkPath(head->next, root->left) || checkPath(head->next, root->right);
}

bool isSubPath(struct ListNode* head, struct TreeNode* root) {
    if (head == NULL) {
        return true;
    }
    if (root == NULL) {
        return false;
    }

    return checkPath(head, root) || isSubPath(head, root->left) || isSubPath(head, root->right);
}