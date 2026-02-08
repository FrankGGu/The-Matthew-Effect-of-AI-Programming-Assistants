int minSubarray(int* nums, int numsSize, int p) {
    long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    int rem = total % p;
    if (rem == 0) return 0;

    int min_len = numsSize;
    long prefix_sum = 0;
    int last_rem[100000] = {0};
    for (int i = 0; i < 100000; i++) {
        last_rem[i] = -1;
    }
    last_rem[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        prefix_sum += nums[i-1];
        int curr_rem = prefix_sum % p;
        int target_rem = (curr_rem - rem + p) % p;
        if (last_rem[target_rem] != -1) {
            int len = i - last_rem[target_rem];
            if (len < min_len) {
                min_len = len;
            }
        }
        last_rem[curr_rem] = i;
    }

    return min_len < numsSize ? min_len : -1;
}