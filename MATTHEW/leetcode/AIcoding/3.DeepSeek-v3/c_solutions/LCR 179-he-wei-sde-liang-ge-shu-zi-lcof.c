int* twoSum(int* prices, int pricesSize, int target, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    int left = 0, right = pricesSize - 1;
    while (left < right) {
        int sum = prices[left] + prices[right];
        if (sum == target) {
            result[0] = prices[left];
            result[1] = prices[right];
            return result;
        } else if (sum < target) {
            left++;
        } else {
            right--;
        }
    }
    return result;
}