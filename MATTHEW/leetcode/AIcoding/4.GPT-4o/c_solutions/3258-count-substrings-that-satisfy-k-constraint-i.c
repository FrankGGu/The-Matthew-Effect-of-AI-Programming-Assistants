int countSubstrings(char * s, int k) {
    int n = strlen(s);
    int count = 0;
    int freq[26] = {0};

    for (int left = 0; left < n; left++) {
        memset(freq, 0, sizeof(freq));
        int distinct_count = 0;

        for (int right = left; right < n; right++) {
            if (freq[s[right] - 'a'] == 0) {
                distinct_count++;
            }
            freq[s[right] - 'a']++;

            if (distinct_count == k) {
                count++;
            } else if (distinct_count > k) {
                break;
            }
        }
    }
    return count;
}