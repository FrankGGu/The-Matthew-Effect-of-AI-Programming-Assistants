int longestPalindrome(char ** words, int wordsSize) {
    int count[26][26] = {0}, res = 0;
    int single = 0;

    for (int i = 0; i < wordsSize; i++) {
        int a = words[i][0] - 'a';
        int b = words[i][1] - 'a';
        count[a][b]++;
    }

    for (int i = 0; i < 26; i++) {
        if (count[i][i] > 0) {
            res += (count[i][i] / 2) * 4;
            if (count[i][i] % 2 == 1) {
                single = 1;
            }
        }
        for (int j = 0; j < 26; j++) {
            if (i != j) {
                res += (count[i][j] < count[j][i] ? count[i][j] : count[j][i]) * 4;
            }
        }
    }

    return res + single;
}