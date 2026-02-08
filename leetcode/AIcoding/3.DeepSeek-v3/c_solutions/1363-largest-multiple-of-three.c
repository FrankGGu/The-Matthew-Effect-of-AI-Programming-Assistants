int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

char* largestMultipleOfThree(int* digits, int digitsSize) {
    int count[10] = {0};
    int sum = 0;

    for (int i = 0; i < digitsSize; i++) {
        count[digits[i]]++;
        sum += digits[i];
    }

    if (sum % 3 == 1) {
        if (!removeDigit(count, 1) && !removeDigit(count, 4) && !removeDigit(count, 7)) {
            removeTwoDigits(count, 2, 5, 8);
        }
    } else if (sum % 3 == 2) {
        if (!removeDigit(count, 2) && !removeDigit(count, 5) && !removeDigit(count, 8)) {
            removeTwoDigits(count, 1, 4, 7);
        }
    }

    return buildResult(count);
}

int removeDigit(int* count, int digit) {
    for (int d = digit; d <= 9; d += 3) {
        if (count[d] > 0) {
            count[d]--;
            return 1;
        }
    }
    return 0;
}

void removeTwoDigits(int* count, int d1, int d2, int d3) {
    int removed = 0;
    for (int d = d1; d <= 9; d += 3) {
        while (count[d] > 0 && removed < 2) {
            count[d]--;
            removed++;
        }
        if (removed == 2) return;
    }
}

char* buildResult(int* count) {
    char* result = (char*)malloc(10005 * sizeof(char));
    int idx = 0;
    int allZero = 1;

    for (int d = 9; d >= 0; d--) {
        if (count[d] > 0 && d > 0) allZero = 0;
        for (int i = 0; i < count[d]; i++) {
            result[idx++] = '0' + d;
        }
    }

    if (idx == 0) {
        result[idx++] = '0';
    } else if (allZero) {
        idx = 0;
        result[idx++] = '0';
    }

    result[idx] = '\0';
    return result;
}