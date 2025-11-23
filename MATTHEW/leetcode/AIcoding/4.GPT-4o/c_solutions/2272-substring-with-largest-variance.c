int largestVariance(char * s) {
    int maxVariance = 0;
    int freq[26] = {0};

    for (char *a = s; *a; a++) freq[*a - 'a']++;

    for (char *a = 'a'; a <= 'z'; a++) {
        for (char *b = 'a'; b <= 'z'; b++) {
            if (a == b || freq[*a - 'a'] == 0 || freq[*b - 'a'] == 0) continue;
            int countA = 0, countB = 0;
            for (char *c = s; *c; c++) {
                if (*c == *a) countA++;
                if (*c == *b) countB++;
                if (countB > 0) maxVariance = fmax(maxVariance, countA - countB);
                if (countA < countB) {
                    countA = 0;
                    countB = 0;
                }
            }
        }
    }
    return maxVariance;
}