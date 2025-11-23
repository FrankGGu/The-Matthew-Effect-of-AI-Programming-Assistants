int numberOfSubarrays(int* nums, int numsSize, int k) {
    int count = 0;
    int oddCount = 0;
    int left = 0;
    int result = 0;
    int prefix = 0;

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] % 2 == 1) {
            oddCount++;
            prefix = 0;
        }

        while (oddCount == k) {
            if (nums[left] % 2 == 1) {
                oddCount--;
            }
            left++;
            prefix++;
        }

        result += prefix;
    }

    return result;
}