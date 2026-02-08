int lengthAfterTransformations(char* s, int t) {
    int freq[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    for (int i = 0; i < t; i++) {
        int temp[26] = {0};
        for (int j = 0; j < 25; j++) {
            temp[j + 1] += freq[j];
        }
        temp[0] += freq[25];
        temp[1] += freq[25];

        for (int j = 0; j < 26; j++) {
            freq[j] = temp[j] % 1000000007;
        }
    }

    long long total = 0;
    for (int i = 0; i < 26; i++) {
        total = (total + freq[i]) % 1000000007;
    }
    return total;
}