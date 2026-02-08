/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findXSum(int* nums, int numsSize, int k, int x, int* returnSize) {
    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));

    for (int i = 0; i <= numsSize - k; i++) {
        int count[51] = {0};
        for (int j = i; j < i + k; j++) {
            count[nums[j]]++;
        }

        int sum = 0;
        for (int num = 50; num >= 1; num--) {
            if (count[num] > 0) {
                int take = (count[num] < x) ? count[num] : x;
                sum += num * take;
                x -= take;
                if (x == 0) break;
            }
        }
        result[i] = sum;
    }

    return result;
}