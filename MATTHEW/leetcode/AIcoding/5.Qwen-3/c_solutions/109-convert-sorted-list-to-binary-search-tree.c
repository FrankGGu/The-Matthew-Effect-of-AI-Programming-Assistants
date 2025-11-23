#include <stdio.h>
#include <stdlib.h>

typedef struct ListNode {
    int val;
    struct ListNode *next;
} ListNode;

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* sortedListToBST(ListNode* head) {
    if (!head) return NULL;

    ListNode* slow = head;
    ListNode* fast = head;
    ListNode* prev = NULL;

    while (fast && fast->next) {
        prev = slow;
        slow = slow->next;
        fast = fast->next->next;
    }

    TreeNode* root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = slow->val;

    if (prev) {
        prev->next = NULL;
        root->left = sortedListToBST(head);
    } else {
        root->left = NULL;
    }

    root->right = sortedListToBST(slow->next);

    return root;
}