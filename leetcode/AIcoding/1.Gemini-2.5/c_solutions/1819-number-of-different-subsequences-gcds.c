#include <stdbool.h>
#include <string.h>

int gcd(int a, int b) {
    while (b) {
        a %= b;
        int temp = a;
        a = b;
        b = temp;
    }
    return a;
}

#define MAX_VAL 200000

static bool present[MAX_VAL + 1];

int countDifferentSubsequenceGCDs(int* nums, int numsSize) {
    memset(present, 0, sizeof(present));

    int max_num = 0;
    for (int i = 0; i < numsSize; i++) {
        present[nums[i]] = true;
        if (nums[i] > max_num) {
            max_num = nums[i];
        }
    }

    int count = 0;
    for (int g = 1; g <= max_num; g++) {
        int current_gcd_for_g = 0;

        for (int multiple = g; multiple <= max_num; multiple += g) {
            if (present[multiple]) {
                if (current_gcd_for_g == 0) {
                    current_gcd_for_g = multiple;
                } else {
                    current_gcd_for_g = gcd(current_gcd_for_g, multiple);
                }
            }
        }

        if (current_gcd_for_g == g) {
            count++;
        }
    }

    return count;
}