#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* createListNode(int val) {
    struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
    newNode->val = val;
    newNode->next = NULL;
    return newNode;
}

void addToList(struct ListNode** head, int val) {
    struct ListNode* newNode = createListNode(val);
    newNode->next = *head;
    *head = newNode;
}

void findNodesAtDistanceK(struct TreeNode* root, struct TreeNode* target, int K, struct ListNode** result) {
    if (!root) return;
    if (K < 0) return;

    if (root == target) {
        addToList(result, root->val);
        return;
    }

    struct ListNode* leftResult = NULL, *rightResult = NULL;
    findNodesAtDistanceK(root->left, target, K, &leftResult);
    findNodesAtDistanceK(root->right, target, K, &rightResult);

    int leftDepth = -1, rightDepth = -1;
    if (leftResult) {
        leftDepth = 0;
        while (leftResult) {
            addToList(result, leftResult->val);
            leftResult = leftResult->next;
        }
    }

    if (rightResult) {
        rightDepth = 0;
        while (rightResult) {
            addToList(result, rightResult->val);
            rightResult = rightResult->next;
        }
    }

    if (leftDepth >= 0) {
        if (leftDepth + 1 == K) addToList(result, root->val);
        findNodesAtDistanceK(root->right, NULL, K - leftDepth - 2, result);
    } else if (rightDepth >= 0) {
        if (rightDepth + 1 == K) addToList(result, root->val);
        findNodesAtDistanceK(root->left, NULL, K - rightDepth - 2, result);
    }
}

struct ListNode* distanceK(struct TreeNode* root, struct TreeNode* target, int K) {
    struct ListNode* result = NULL;
    findNodesAtDistanceK(root, target, K, &result);
    return result;
}