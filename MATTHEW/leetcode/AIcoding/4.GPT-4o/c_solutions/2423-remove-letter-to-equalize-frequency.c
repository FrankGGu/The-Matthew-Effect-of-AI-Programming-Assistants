bool equalFrequency(char * word) {
    int freq[26] = {0};
    int count[101] = {0};
    int maxFreq = 0;

    for (int i = 0; word[i]; i++) {
        freq[word[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            count[freq[i]]++;
            if (freq[i] > maxFreq) {
                maxFreq = freq[i];
            }
        }
    }

    for (int i = 1; i <= maxFreq; i++) {
        if (count[i] == 0) continue;

        count[i]--;
        if (count[i] == 0) maxFreq--;

        int totalFreq = 0;
        for (int j = 1; j <= maxFreq; j++) {
            totalFreq += count[j] * j;
        }

        if (totalFreq == 0 || (totalFreq == 1 && count[maxFreq + 1] == 1)) {
            return true;
        }

        count[i]++;
    }

    return false;
}