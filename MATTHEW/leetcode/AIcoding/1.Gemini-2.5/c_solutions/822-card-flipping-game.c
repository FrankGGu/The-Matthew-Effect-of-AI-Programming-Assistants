#include <stdbool.h>
#include <limits.h>

int flipgame(int* fronts, int frontsSize, int* backs, int backsSize) {
    bool is_bad[2001] = {false};
    bool seen_number[2001] = {false};

    for (int i = 0; i < frontsSize; i++) {
        if (fronts[i] == backs[i]) {
            is_bad[fronts[i]] = true;
        }
        seen_number[fronts[i]] = true;
        seen_number[backs[i]] = true;
    }

    int min_good_num = INT_MAX;

    for (int num = 1; num <= 2000; num++) {
        if (seen_number[num] && !is_bad[num]) {
            if (num < min_good_num) {
                min_good_num = num;
            }
        }
    }

    return min_good_num;
}