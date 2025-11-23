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

int getListSize(struct ListNode* head) {
    int size = 0;
    struct ListNode* current = head;
    while (current != NULL) {
        size++;
        current = current->next;
    }
    return size;
}

struct TreeNode* buildBSTRecursive(struct ListNode** headRef, int start, int end) {
    if (start > end) {
        return NULL;
    }

    int mid = start + (end - start) / 2;

    struct TreeNode* leftChild = buildBSTRecursive(headRef, start, mid - 1);

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = (*headRef)->val;
    root->left = leftChild;

    *headRef = (*headRef)->next;

    struct TreeNode* rightChild = buildBSTRecursive(headRef, mid + 1, end);
    root->right = rightChild;

    return root;
}

struct TreeNode* sortedListToBST(struct ListNode* head) {
    if (head == NULL) {
        return NULL;
    }

    int size = getListSize(head);

    return buildBSTRecursive(&head, 0, size - 1);
}