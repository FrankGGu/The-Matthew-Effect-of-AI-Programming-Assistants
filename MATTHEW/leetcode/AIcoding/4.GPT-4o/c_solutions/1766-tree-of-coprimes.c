#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int gcd(int a, int b) {
    while (b != 0) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

void dfs(TreeNode* root, int* ans, int* idx, int* coprime) {
    if (!root) return;
    int current = root->val;
    int coprimeCount = 0;
    for (int i = 0; i < *idx; i++) {
        if (gcd(current, coprime[i]) == 1) {
            coprimeCount++;
        }
    }
    ans[*idx] = coprimeCount;
    coprime[(*idx)++] = current;
    dfs(root->left, ans, idx, coprime);
    dfs(root->right, ans, idx, coprime);
    (*idx)--;
}

int* getCoprimes(TreeNode* root, int* returnSize) {
    int* ans = (int*)malloc(sizeof(int) * 10000);
    int* coprime = (int*)malloc(sizeof(int) * 10000);
    int idx = 0;
    dfs(root, ans, &idx, coprime);
    *returnSize = idx;
    free(coprime);
    return ans;
}