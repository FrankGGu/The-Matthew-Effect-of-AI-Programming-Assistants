bool equalFrequency(char* word) {
    int freq[26] = {0};
    int len = strlen(word);

    for (int i = 0; i < len; i++) {
        freq[word[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) continue;

        freq[i]--;

        int target = -1;
        int valid = 1;
        for (int j = 0; j < 26; j++) {
            if (freq[j] == 0) continue;
            if (target == -1) {
                target = freq[j];
            } else if (freq[j] != target) {
                valid = 0;
                break;
            }
        }

        if (valid) return true;

        freq[i]++;
    }

    return false;
}