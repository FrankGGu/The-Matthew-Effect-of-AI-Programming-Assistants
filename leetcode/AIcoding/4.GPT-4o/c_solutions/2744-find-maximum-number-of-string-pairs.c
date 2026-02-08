int maximumNumberOfStringPairs(char **words, int wordsSize) {
    int count = 0;
    int seen[128] = {0};

    for (int i = 0; i < wordsSize; i++) {
        if (seen[words[i][1] - 'a'] & (1 << (words[i][0] - 'a'))) {
            count++;
        }
        seen[words[i][0] - 'a'] |= (1 << (words[i][1] - 'a'));
    }

    return count;
}