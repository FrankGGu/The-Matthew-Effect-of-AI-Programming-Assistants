int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int countKSubsequencesWithMaxBeauty(char* s, int k) {
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int counts[26];
    int size = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            counts[size++] = freq[i];
        }
    }

    if (size < k) return 0;

    qsort(counts, size, sizeof(int), cmp);

    long long result = 1;
    int mod = 1000000007;
    int last_count = -1;
    int last_used = 0;

    for (int i = 0; i < k; i++) {
        result = (result * counts[i]) % mod;
        if (counts[i] == counts[k-1]) {
            last_count = counts[i];
            last_used++;
        }
    }

    if (last_count == -1) return result;

    int total_last = 0;
    int available_last = 0;
    for (int i = 0; i < size; i++) {
        if (counts[i] == last_count) {
            total_last++;
        } else if (counts[i] > last_count) {
            available_last++;
        }
    }

    if (available_last >= k) return result;

    int need_last = k - available_last;

    long long comb = 1;
    for (int i = 0; i < need_last; i++) {
        comb = comb * (total_last - i) / (i + 1);
    }

    result = (result * comb) % mod;

    return result;
}