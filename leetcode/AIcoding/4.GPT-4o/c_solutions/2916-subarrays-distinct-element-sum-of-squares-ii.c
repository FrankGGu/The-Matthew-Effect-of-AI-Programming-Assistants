int distinctElementSumOfSquares(int* nums, int numsSize) {
    int left = 0, right = 0, sum = 0, result = 0;
    int count[100001] = {0};

    while (right < numsSize) {
        if (count[nums[right]] == 0) {
            sum += nums[right] * nums[right];
        }
        count[nums[right]]++;
        right++;

        while (count[nums[right - 1]] > 1) {
            count[nums[left]]--;
            if (count[nums[left]] == 0) {
                sum -= nums[left] * nums[left];
            }
            left++;
        }

        result += sum;
    }

    return result;
}