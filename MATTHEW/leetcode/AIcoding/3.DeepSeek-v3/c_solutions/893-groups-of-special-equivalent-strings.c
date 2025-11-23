int numSpecialEquivGroups(char** words, int wordsSize) {
    int groups[wordsSize];
    for (int i = 0; i < wordsSize; i++) groups[i] = 0;

    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (groups[i]) continue;

        count++;
        groups[i] = count;

        int len = strlen(words[i]);
        char even1[26] = {0}, odd1[26] = {0};
        for (int k = 0; k < len; k++) {
            if (k % 2 == 0) even1[words[i][k] - 'a']++;
            else odd1[words[i][k] - 'a']++;
        }

        for (int j = i + 1; j < wordsSize; j++) {
            if (groups[j]) continue;

            if (strlen(words[j]) != len) continue;

            char even2[26] = {0}, odd2[26] = {0};
            for (int k = 0; k < len; k++) {
                if (k % 2 == 0) even2[words[j][k] - 'a']++;
                else odd2[words[j][k] - 'a']++;
            }

            int match = 1;
            for (int k = 0; k < 26; k++) {
                if (even1[k] != even2[k] || odd1[k] != odd2[k]) {
                    match = 0;
                    break;
                }
            }

            if (match) groups[j] = count;
        }
    }

    return count;
}