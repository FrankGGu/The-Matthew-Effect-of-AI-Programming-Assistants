/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** getWordsInLongestSubsequence(int n, char** words, int wordsSize, int* groups, int groupsSize, int* returnSize) {
    int* dp = (int*)malloc(n * sizeof(int));
    int* prev = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = 1;
        prev[i] = -1;
    }

    int maxLen = 1;
    int lastIdx = 0;

    for (int i = 1; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (groups[i] != groups[j]) {
                int len1 = strlen(words[i]);
                int len2 = strlen(words[j]);
                if (len1 != len2) continue;

                int diff = 0;
                for (int k = 0; k < len1; k++) {
                    if (words[i][k] != words[j][k]) {
                        diff++;
                        if (diff > 1) break;
                    }
                }

                if (diff == 1) {
                    if (dp[j] + 1 > dp[i]) {
                        dp[i] = dp[j] + 1;
                        prev[i] = j;
                        if (dp[i] > maxLen) {
                            maxLen = dp[i];
                            lastIdx = i;
                        }
                    }
                }
            }
        }
    }

    char** result = (char**)malloc(maxLen * sizeof(char*));
    int idx = lastIdx;
    *returnSize = maxLen;

    for (int i = maxLen - 1; i >= 0; i--) {
        result[i] = words[idx];
        idx = prev[idx];
    }

    free(dp);
    free(prev);
    return result;
}