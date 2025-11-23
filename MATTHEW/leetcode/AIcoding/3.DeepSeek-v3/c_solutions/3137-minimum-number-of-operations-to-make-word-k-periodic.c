int minimumOperationsToMakeKPeriodic(char* word, int k) {
    int len = strlen(word);
    int maxFreq = 0;
    int total = len / k;

    for (int i = 0; i < k; i++) {
        int freq[26] = {0};
        for (int j = i; j < len; j += k) {
            freq[word[j] - 'a']++;
        }
        int max = 0;
        for (int j = 0; j < 26; j++) {
            if (freq[j] > max) {
                max = freq[j];
            }
        }
        maxFreq += max;
    }

    return total - maxFreq;
}