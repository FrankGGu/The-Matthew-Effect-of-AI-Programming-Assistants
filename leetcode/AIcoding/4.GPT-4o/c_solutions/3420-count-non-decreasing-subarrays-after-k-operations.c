#define MAXN 200005

int countNonDecreasing(int* nums, int numsSize, int k) {
    int left = 0, right = 0, count = 0;
    int operations[MAXN] = {0};

    while (right < numsSize) {
        if (right > 0 && nums[right] < nums[right - 1]) {
            left = right;
        }
        while (left < right && nums[right] < nums[left]) {
            left++;
        }

        int neededOps = 0;
        for (int i = left; i < right; i++) {
            if (nums[i] > nums[right]) {
                neededOps += nums[i] - nums[right];
            }
        }

        if (neededOps <= k) {
            count += (right - left + 1);
        } else {
            while (neededOps > k && left <= right) {
                neededOps -= (nums[left] - nums[left - 1]);
                left++;
            }
            if (neededOps <= k) {
                count += (right - left + 1);
            }
        }
        right++;
    }

    return count;
}