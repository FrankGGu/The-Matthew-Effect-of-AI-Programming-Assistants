#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool isSubPath(struct ListNode* head, struct TreeNode* root) {
    if (!head) return true;
    if (!root) return false;

    bool dfs(struct ListNode* head, struct TreeNode* root) {
        if (!head) return true;
        if (!root) return false;
        return (head->val == root->val && (dfs(head->next, root->left) || dfs(head->next, root->right)));
    }

    return dfs(head, root) || isSubPath(head, root->left) || isSubPath(head, root->right);
}