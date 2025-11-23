#define MAXN 10001

int* sumPrefixScores(char ** words, int wordsSize, int* returnSize) {
    int *result = (int *)malloc(sizeof(int) * wordsSize);
    int trie[MAXN][26] = {0}, count[MAXN] = {0}, nodeCount = 1;

    for (int i = 0; i < wordsSize; i++) {
        int node = 0;
        for (int j = 0; words[i][j]; j++) {
            int ch = words[i][j] - 'a';
            if (!trie[node][ch]) {
                trie[node][ch] = nodeCount++;
            }
            node = trie[node][ch];
            count[node]++;
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        int node = 0, score = 0;
        for (int j = 0; words[i][j]; j++) {
            int ch = words[i][j] - 'a';
            node = trie[node][ch];
            score += count[node];
        }
        result[i] = score;
    }

    *returnSize = wordsSize;
    return result;
}