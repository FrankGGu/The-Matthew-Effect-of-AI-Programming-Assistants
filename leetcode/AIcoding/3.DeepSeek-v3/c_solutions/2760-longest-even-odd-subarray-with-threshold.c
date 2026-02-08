int longestAlternatingSubarray(int* nums, int numsSize, int threshold) {
    int max_len = 0;
    int i = 0;

    while (i < numsSize) {
        if (nums[i] % 2 != 0 || nums[i] > threshold) {
            i++;
            continue;
        }

        int j = i + 1;
        while (j < numsSize) {
            if (nums[j] > threshold || nums[j] % 2 == nums[j-1] % 2) {
                break;
            }
            j++;
        }

        if (j - i > max_len) {
            max_len = j - i;
        }

        i++;
    }

    return max_len;
}