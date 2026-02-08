int maximumDeletions(char * s) {
    int n = strlen(s);
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int deletions = 0;
    int max_allowed = n;

    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            if (count[i] > max_allowed) {
                deletions += count[i] - max_allowed;
                count[i] = max_allowed;
            }
            max_allowed = count[i] - 1 < 0 ? 0 : count[i] - 1;
        }
    }

    return deletions;
}