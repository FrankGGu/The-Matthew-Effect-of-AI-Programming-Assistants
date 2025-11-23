#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minSwaps(int arr[], int n) {
    int ans = 0;
    int temp[n];
    for (int i = 0; i < n; i++) {
        temp[i] = arr[i];
    }

    qsort(temp, n, sizeof(int), cmpfunc);

    int pos[n];
    for (int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++){
            if(arr[i] == temp[j]){
                pos[i] = j;
                break;
            }
        }
    }

    int vis[n];
    for (int i = 0; i < n; i++) {
        vis[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        if (vis[i] || pos[i] == i)
            continue;

        int cycle_size = 0;
        int j = i;
        while (!vis[j]) {
            vis[j] = 1;
            j = pos[j];
            cycle_size++;
        }

        if (cycle_size > 0) {
            ans += (cycle_size - 1);
        }
    }

    return ans;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int minimumOperations(struct TreeNode* root) {
    if (!root) return 0;

    int operations = 0;
    struct TreeNode* queue[100000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        int levelValues[levelSize];
        int tempFront = front;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[tempFront++];
            levelValues[i] = node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        front = tempFront;
        operations += minSwaps(levelValues, levelSize);
    }

    return operations;
}