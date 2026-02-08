int countSubarrays(int* nums, int numsSize, int k) {
    int maxElement = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > maxElement) {
            maxElement = nums[i];
        }
    }

    int left = 0;
    int count = 0;
    int result = 0;

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] == maxElement) {
            count++;
        }

        while (count >= k) {
            result += numsSize - right;
            if (nums[left] == maxElement) {
                count--;
            }
            left++;
        }
    }

    return result;
}