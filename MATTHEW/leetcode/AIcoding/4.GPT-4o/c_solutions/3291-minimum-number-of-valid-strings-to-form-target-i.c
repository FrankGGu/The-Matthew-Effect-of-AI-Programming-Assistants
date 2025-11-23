int minNumberOfStrings(char **strings, int stringsSize, char *target) {
    int freq[26] = {0};
    for (int i = 0; target[i]; i++) {
        freq[target[i] - 'a']++;
    }

    int res = 0;
    while (1) {
        int count[26] = {0};
        for (int i = 0; i < stringsSize; i++) {
            for (int j = 0; strings[i][j]; j++) {
                count[strings[i][j] - 'a']++;
            }
        }

        int possible = 1;
        for (int i = 0; i < 26; i++) {
            if (freq[i] > count[i]) {
                possible = 0;
                break;
            }
        }

        if (!possible) break;

        res++;
        for (int i = 0; i < stringsSize; i++) {
            for (int j = 0; strings[i][j]; j++) {
                count[strings[i][j] - 'a']--;
            }
        }
    }

    return res;
}