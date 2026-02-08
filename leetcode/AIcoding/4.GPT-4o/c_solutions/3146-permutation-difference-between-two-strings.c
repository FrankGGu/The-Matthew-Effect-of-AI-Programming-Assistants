int minimumDifference(char *s1, char *s2) {
    int len = strlen(s1);
    int half = len / 2;
    int count[26] = {0};
    int s1_count[26] = {0};
    int s2_count[26] = {0};
    int i, j, min_diff = INT_MAX;

    for (i = 0; i < half; i++) {
        s1_count[s1[i] - 'a']++;
        s2_count[s2[i] - 'a']++;
    }

    for (i = 0; i < half; i++) {
        count[s1[i] - 'a']++;
        count[s2[i + half] - 'a']--;
    }

    for (i = 0; i < (1 << half); i++) {
        int diff = 0;
        int temp_count[26] = {0};

        for (j = 0; j < half; j++) {
            if (i & (1 << j)) {
                temp_count[s1[j] - 'a']++;
            } else {
                temp_count[s2[j] - 'a']++;
            }
        }

        for (j = 0; j < 26; j++) {
            diff += abs(temp_count[j] - count[j]);
        }

        min_diff = fmin(min_diff, diff);
    }

    return min_diff;
}