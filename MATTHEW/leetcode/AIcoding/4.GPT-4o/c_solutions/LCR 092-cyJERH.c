int minDeletions(char * s) {
    int count[26] = {0};
    for (int i = 0; s[i]; i++) {
        count[s[i] - 'a']++;
    }
    int deletions = 0;
    int frequencies[26] = {0};

    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            while (frequencies[count[i]] > 0) {
                deletions++;
                count[i]--;
            }
            frequencies[count[i]]++;
        }
    }

    return deletions;
}