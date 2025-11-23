/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int minOperations(int* nums, int numsSize, int target) {
    long long sum = 0;
    int freq[32] = {0};

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        int power = 0;
        int num = nums[i];
        while (num > 1) {
            num >>= 1;
            power++;
        }
        freq[power]++;
    }

    if (sum < target) return -1;

    int operations = 0;
    for (int i = 0; i < 31; i++) {
        if (target & (1 << i)) {
            if (freq[i] > 0) {
                freq[i]--;
            } else {
                int j = i;
                while (j < 31 && freq[j] == 0) {
                    j++;
                    operations++;
                }
                freq[j]--;
                for (int k = j - 1; k >= i; k--) {
                    freq[k] += 1;
                }
            }
        }
        freq[i + 1] += freq[i] / 2;
    }

    return operations;
}