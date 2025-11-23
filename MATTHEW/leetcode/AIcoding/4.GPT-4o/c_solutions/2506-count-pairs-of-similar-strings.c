int countSimilarPairs(char ** words, int wordsSize) {
    int count = 0;
    int freq[26];

    for (int i = 0; i < wordsSize; i++) {
        memset(freq, 0, sizeof(freq));
        for (char *ch = words[i]; *ch; ch++) {
            freq[*ch - 'a']++;
        }

        for (int j = i + 1; j < wordsSize; j++) {
            int same = 1;
            for (int k = 0; k < 26; k++) {
                if (freq[k] != (words[j][k] ? 1 : 0)) {
                    same = 0;
                    break;
                }
            }
            count += same;
        }
    }

    return count;
}