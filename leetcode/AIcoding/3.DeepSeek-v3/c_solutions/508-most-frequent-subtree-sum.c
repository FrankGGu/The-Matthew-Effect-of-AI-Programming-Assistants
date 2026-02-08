/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int calculateSum(struct TreeNode* root, int* sums, int* count, int* maxCount, int* maxFreq) {
    if (root == NULL) return 0;

    int leftSum = calculateSum(root->left, sums, count, maxCount, maxFreq);
    int rightSum = calculateSum(root->right, sums, count, maxCount, maxFreq);

    int total = root->val + leftSum + rightSum;

    sums[*count] = total;
    (*count)++;

    int freq = 1;
    for (int i = 0; i < *count - 1; i++) {
        if (sums[i] == total) {
            freq++;
        }
    }

    if (freq > *maxFreq) {
        *maxFreq = freq;
        *maxCount = 1;
    } else if (freq == *maxFreq) {
        (*maxCount)++;
    }

    return total;
}

int* findFrequentTreeSum(struct TreeNode* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int* sums = (int*)malloc(10000 * sizeof(int));
    int count = 0;
    int maxFreq = 0;
    int maxCount = 0;

    calculateSum(root, sums, &count, &maxCount, &maxFreq);

    int* result = (int*)malloc(maxCount * sizeof(int));
    int resultIndex = 0;

    for (int i = 0; i < count; i++) {
        int freq = 0;
        for (int j = 0; j < count; j++) {
            if (sums[j] == sums[i]) {
                freq++;
            }
        }
        if (freq == maxFreq) {
            int duplicate = 0;
            for (int k = 0; k < resultIndex; k++) {
                if (result[k] == sums[i]) {
                    duplicate = 1;
                    break;
                }
            }
            if (!duplicate) {
                result[resultIndex++] = sums[i];
            }
        }
    }

    free(sums);
    *returnSize = resultIndex;
    return result;
}