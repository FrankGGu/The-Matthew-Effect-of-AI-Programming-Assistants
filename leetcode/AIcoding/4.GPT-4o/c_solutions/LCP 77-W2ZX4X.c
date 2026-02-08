int minRuin(char *runes, int runesSize) {
    int count[256] = {0};
    int unique = 0;

    for (int i = 0; i < runesSize; i++) {
        if (count[(unsigned char)runes[i]] == 0) {
            unique++;
        }
        count[(unsigned char)runes[i]]++;
    }

    int left = 0, right = 0, minRuinCount = runesSize;

    while (right < runesSize) {
        count[(unsigned char)runes[right]]--;
        if (count[(unsigned char)runes[right]] == 0) {
            unique--;
        }
        right++;

        while (unique == 0) {
            minRuinCount = fmin(minRuinCount, right - left);
            count[(unsigned char)runes[left]]++;
            if (count[(unsigned char)runes[left]] == 1) {
                unique++;
            }
            left++;
        }
    }

    return minRuinCount == runesSize ? 0 : minRuinCount;
}