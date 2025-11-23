int beautySum(char* s) {
    int len = strlen(s);
    int sum = 0;

    for (int i = 0; i < len; i++) {
        int freq[26] = {0};
        for (int j = i; j < len; j++) {
            freq[s[j] - 'a']++;

            int maxFreq = 0;
            int minFreq = len;

            for (int k = 0; k < 26; k++) {
                if (freq[k] > 0) {
                    if (freq[k] > maxFreq) maxFreq = freq[k];
                    if (freq[k] < minFreq) minFreq = freq[k];
                }
            }

            sum += (maxFreq - minFreq);
        }
    }

    return sum;
}