#define MAX_VAL 100000

int minimumOperations(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    int freq_even[MAX_VAL + 1];
    int freq_odd[MAX_VAL + 1];

    for (int i = 0; i <= MAX_VAL; i++) {
        freq_even[i] = 0;
        freq_odd[i] = 0;
    }

    int count_even_indices = (numsSize + 1) / 2;
    int count_odd_indices = numsSize / 2;

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            freq_even[nums[i]]++;
        } else {
            freq_odd[nums[i]]++;
        }
    }

    int max1_even_val = -1, max1_even_freq = 0;
    int max2_even_val = -1, max2_even_freq = 0;
    for (int v = 1; v <= MAX_VAL; v++) {
        if (freq_even[v] > max1_even_freq) {
            max2_even_freq = max1_even_freq;
            max2_even_val = max1_even_val;
            max1_even_freq = freq_even[v];
            max1_even_val = v;
        } else if (freq_even[v] > max2_even_freq) {
            max2_even_freq = freq_even[v];
            max2_even_val = v;
        }
    }

    int max1_odd_val = -1, max1_odd_freq = 0;
    int max2_odd_val = -1, max2_odd_freq = 0;
    for (int v = 1; v <= MAX_VAL; v++) {
        if (freq_odd[v] > max1_odd_freq) {
            max2_odd_freq = max1_odd_freq;
            max2_odd_val = max1_odd_val;
            max1_odd_freq = freq_odd[v];
            max1_odd_val = v;
        } else if (freq_odd[v] > max2_odd_freq) {
            max2_odd_freq = freq_odd[v];
            max2_odd_val = v;
        }
    }

    int ops;

    if (max1_even_val != max1_odd_val) {
        ops = (count_even_indices - max1_even_freq) + (count_odd_indices - max1_odd_freq);
    } else {
        int ops1 = (count_even_indices - max1_even_freq) + (count_odd_indices - max2_odd_freq);
        int ops2 = (count_even_indices - max2_even_freq) + (count_odd_indices - max1_odd_freq);

        ops = (ops1 < ops2) ? ops1 : ops2;
    }

    return ops;
}