int countGoodSubstrings(char * s, int k) {
    int n = strlen(s), count = 0;
    int freq[26] = {0};

    for (int left = 0, right = 0; right < n; right++) {
        freq[s[right] - 'a']++;

        while (right - left + 1 - freq[s[right] - 'a'] > k) {
            freq[s[left] - 'a']--;
            left++;
        }

        count += right - left + 1;
    }

    return count;
}