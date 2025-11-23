#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool dfs(struct ListNode* head, struct TreeNode* root) {
    if (!head) return true;
    if (!root) return false;
    if (head->val != root->val) return false;
    return dfs(head->next, root->left) || dfs(head->next, root->right);
}

bool isSubPath(struct ListNode* head, struct TreeNode* root) {
    if (!head) return true;
    if (!root) return false;
    return dfs(head, root) || isSubPath(head, root->left) || isSubPath(head, root->right);
}