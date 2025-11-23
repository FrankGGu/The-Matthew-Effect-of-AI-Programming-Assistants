#include <stdbool.h>

bool isFascinating(int n) {
    bool seen[10] = {false};

    int nums[3] = {n, n * 2, n * 3};

    for (int i = 0; i < 3; i++) {
        int currentNum = nums[i];
        while (currentNum > 0) {
            int digit = currentNum % 10;
            if (digit == 0 || seen[digit]) {
                return false;
            }
            seen[digit] = true;
            currentNum /= 10;
        }
    }

    for (int i = 1; i <= 9; i++) {
        if (!seen[i]) {
            return false;
        }
    }

    return true;
}