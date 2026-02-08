typedef struct {
    char word[3];
    int count;
} WordCount;

int countChars[26][26] = {0};

int longestPalindrome(char** words, int wordsSize) {
    memset(countChars, 0, sizeof(countChars));

    for (int i = 0; i < wordsSize; i++) {
        int first = words[i][0] - 'a';
        int second = words[i][1] - 'a';
        countChars[first][second]++;
    }

    int length = 0;
    int centralUsed = 0;

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i == j) {
                int count = countChars[i][j];
                length += (count / 2) * 4;
                if (count % 2 == 1 && !centralUsed) {
                    length += 2;
                    centralUsed = 1;
                }
            } else {
                int count1 = countChars[i][j];
                int count2 = countChars[j][i];
                int minCount = count1 < count2 ? count1 : count2;
                length += minCount * 4;
                countChars[i][j] -= minCount;
                countChars[j][i] -= minCount;
            }
        }
    }

    return length;
}