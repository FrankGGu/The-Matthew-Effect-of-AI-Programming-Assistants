int maxMultiplicationScore(int* nums, int numsSize, int k) {
    long long mod = 1e9 + 7;
    long long result = 1;
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count < k) {
            result = (result * nums[i]) % mod;
            count++;
        } else {
            int minIndex = 0;
            for (int j = 1; j < k; j++) {
                if (nums[j] < nums[minIndex]) {
                    minIndex = j;
                }
            }
            if (nums[i] > nums[minIndex]) {
                result = (result / nums[minIndex] * nums[i]) % mod;
                nums[minIndex] = nums[i];
            }
        }
    }

    return (int)result;
}