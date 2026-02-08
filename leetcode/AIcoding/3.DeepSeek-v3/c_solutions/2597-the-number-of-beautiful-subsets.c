int beautifulSubsets(int* nums, int numsSize, int k) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int* freq = (int*)calloc(max_val + 1, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int result = 1;
    for (int i = 1; i <= max_val; i++) {
        if (freq[i] == 0) continue;

        int count = 0;
        int current = i;
        int prev1 = 1, prev2 = 1;

        while (current <= max_val && freq[current] > 0) {
            int take = (1 << freq[current]) - 1;
            int temp = prev1;
            prev1 = prev1 + take * prev2;
            prev2 = temp;
            current += k;
            count++;
        }

        result *= prev1;
    }

    free(freq);
    return result - 1;
}