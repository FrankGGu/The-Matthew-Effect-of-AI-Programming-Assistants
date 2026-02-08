int minLength(char* s, int k) {
    int n = strlen(s);
    int maxFreq = 0;
    int left = 0;
    int result = n;

    int freq[26] = {0};

    for (int right = 0; right < n; right++) {
        freq[s[right] - 'a']++;
        maxFreq = fmax(maxFreq, freq[s[right] - 'a']);

        while (right - left + 1 - maxFreq > k) {
            freq[s[left] - 'a']--;
            left++;

            maxFreq = 0;
            for (int i = 0; i < 26; i++) {
                maxFreq = fmax(maxFreq, freq[i]);
            }
        }

        if (right - left + 1 - maxFreq <= k) {
            result = fmin(result, right - left + 1);
        }
    }

    return result;
}