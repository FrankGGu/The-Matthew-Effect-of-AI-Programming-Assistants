int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int minimumDeletions(char* word, int k) {
    int freq[26] = {0};
    for (int i = 0; word[i]; i++) {
        freq[word[i] - 'a']++;
    }

    int counts[26];
    int n = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            counts[n++] = freq[i];
        }
    }

    qsort(counts, n, sizeof(int), cmp);

    int ans = 1e9;
    for (int i = 0; i < n; i++) {
        int target = counts[i];
        int deletions = 0;
        for (int j = 0; j < n; j++) {
            if (counts[j] < target) {
                deletions += counts[j];
            } else if (counts[j] > target + k) {
                deletions += counts[j] - (target + k);
            }
        }
        if (deletions < ans) ans = deletions;
    }

    return ans;
}