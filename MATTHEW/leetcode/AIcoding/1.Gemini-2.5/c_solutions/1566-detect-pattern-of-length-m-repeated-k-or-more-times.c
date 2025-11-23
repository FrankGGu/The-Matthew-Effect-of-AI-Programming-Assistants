#include <stdbool.h>

bool containPattern(int* arr, int arrSize, int m, int k) {
    for (int i = 0; i <= arrSize - m * k; ++i) {
        int repetitions = 1;
        for (int j = 1; j < k; ++j) {
            bool currentPatternMatches = true;
            for (int l = 0; l < m; ++l) {
                if (arr[i + l] != arr[i + j * m + l]) {
                    currentPatternMatches = false;
                    break;
                }
            }
            if (currentPatternMatches) {
                repetitions++;
            } else {
                break;
            }
        }
        if (repetitions >= k) {
            return true;
        }
    }
    return false;
}