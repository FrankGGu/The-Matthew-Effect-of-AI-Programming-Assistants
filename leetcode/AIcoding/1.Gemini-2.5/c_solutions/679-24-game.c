#include <stdbool.h>
#include <math.h> // For fabs

#define EPSILON 1e-6

bool solve(double* nums, int n) {
    if (n == 1) {
        return fabs(nums[0] - 24.0) < EPSILON;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            double next_nums[n - 1];
            int k = 0;

            for (int l = 0; l < n; l++) {
                if (l != i && l != j) {
                    next_nums[k++] = nums[l];
                }
            }

            // Addition
            next_nums[k] = nums[i] + nums[j];
            if (solve(next_nums, n - 1)) return true;

            // Subtraction (nums[i] - nums[j])
            next_nums[k] = nums[i] - nums[j];
            if (solve(next_nums, n - 1)) return true;

            // Subtraction (nums[j] - nums[i])
            next_nums[k] = nums[j] - nums[i];
            if (solve(next_nums, n - 1)) return true;

            // Multiplication
            next_nums[k] = nums[i] * nums[j];
            if (solve(next_nums, n - 1)) return true;

            // Division (nums[i] / nums[j])
            if (fabs(nums[j]) > EPSILON) {
                next_nums[k] = nums[i] / nums[j];
                if (solve(next_nums, n - 1)) return true;
            }

            // Division (nums[j] / nums[i])
            if (fabs(nums[i]) > EPSILON) {
                next_nums[k] = nums[j] / nums[i];
                if (solve(next_nums, n - 1)) return true;
            }
        }
    }

    return false;
}

bool judgePoint24(int* cards, int cardsSize) {
    double nums[cardsSize];
    for (int i = 0; i < cardsSize; i++) {
        nums[i] = (double)cards[i];
    }
    return solve(nums, cardsSize);
}