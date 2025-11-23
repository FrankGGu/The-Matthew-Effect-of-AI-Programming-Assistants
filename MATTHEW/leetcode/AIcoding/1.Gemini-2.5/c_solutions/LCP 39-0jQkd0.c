#include <stddef.h>

int singleNumber(int* nums, int numsSize) {
    int result = 0;
    for (int i = 0; i < 32; i++) {
        int sum_bits = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((nums[j] >> i) & 1) {
                sum_bits++;
            }
        }
        if (sum_bits % 3 != 0) {
            result |= (1 << i);
        }
    }
    return result;
}