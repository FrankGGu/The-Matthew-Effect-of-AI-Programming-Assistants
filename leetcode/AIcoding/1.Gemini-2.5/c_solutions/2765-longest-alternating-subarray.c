int longestAlternatingSubarray(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0;
    }

    int max_len = 0;

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] != nums[i+1]) {
            int current_len = 2;
            int val1 = nums[i];
            int val2 = nums[i+1];

            for (int k = i + 2; k < numsSize; k++) {
                if ((k - i) % 2 == 0) { // Current element should match val1 (nums[i])
                    if (nums[k] == val1) {
                        current_len++;
                    } else {
                        break; 
                    }
                } else { // Current element should match val2 (nums[i+1])
                    if (nums[k] == val2) {
                        current_len++;
                    } else {
                        break;
                    }
                }
            }
            if (current_len > max_len) {
                max_len = current_len;
            }
        }
    }

    return max_len;
}