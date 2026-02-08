#include <stdbool.h>

void getDigitCounts(int num, int counts[10]) {
    for (int i = 0; i < 10; i++) {
        counts[i] = 0;
    }
    while (num > 0) {
        counts[num % 10]++;
        num /= 10;
    }
}

bool compareCounts(int counts1[10], int counts2[10]) {
    for (int i = 0; i < 10; i++) {
        if (counts1[i] != counts2[i]) {
            return false;
        }
    }
    return true;
}

bool reorderedPowerOf2(int n) {
    int n_counts[10];
    getDigitCounts(n, n_counts);

    for (int i = 0; i <= 30; i++) {
        int powerOf2 = 1 << i;
        int p_counts[10];
        getDigitCounts(powerOf2, p_counts);
        if (compareCounts(n_counts, p_counts)) {
            return true;
        }
    }
    return false;
}