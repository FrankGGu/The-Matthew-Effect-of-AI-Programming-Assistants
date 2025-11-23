int maxDifference(char* s) {
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    int maxEven = -1;
    int minOdd = 100001;

    for (int i = 0; i < 26; i++) {
        if (freq[i] == 0) continue;

        if (freq[i] % 2 == 0) {
            if (freq[i] > maxEven) {
                maxEven = freq[i];
            }
        } else {
            if (freq[i] < minOdd) {
                minOdd = freq[i];
            }
        }
    }

    if (maxEven == -1 || minOdd == 100001) {
        return 0;
    }

    return maxEven - minOdd;
}