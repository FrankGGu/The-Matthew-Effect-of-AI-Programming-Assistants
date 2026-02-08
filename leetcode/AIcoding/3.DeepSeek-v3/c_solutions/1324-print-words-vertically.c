/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** printVertically(char * s, int* returnSize){
    // Count words and find max length
    int wordCount = 0;
    int maxLen = 0;
    int currentLen = 0;

    for (int i = 0; s[i]; i++) {
        if (s[i] == ' ') {
            if (currentLen > 0) {
                wordCount++;
                if (currentLen > maxLen) maxLen = currentLen;
                currentLen = 0;
            }
        } else {
            currentLen++;
        }
    }
    if (currentLen > 0) {
        wordCount++;
        if (currentLen > maxLen) maxLen = currentLen;
    }

    // Allocate result array
    char **result = (char **)malloc(maxLen * sizeof(char *));
    for (int i = 0; i < maxLen; i++) {
        result[i] = (char *)malloc((wordCount + 1) * sizeof(char));
        for (int j = 0; j < wordCount; j++) {
            result[i][j] = ' ';
        }
        result[i][wordCount] = '\0';
    }

    // Fill the result
    int wordIndex = 0;
    int charIndex = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == ' ') {
            if (charIndex > 0) {
                wordIndex++;
                charIndex = 0;
            }
        } else {
            result[charIndex][wordIndex] = s[i];
            charIndex++;
        }
    }

    // Remove trailing spaces from each string
    for (int i = 0; i < maxLen; i++) {
        int lastNonSpace = -1;
        for (int j = 0; j < wordCount; j++) {
            if (result[i][j] != ' ') {
                lastNonSpace = j;
            }
        }
        if (lastNonSpace != -1) {
            result[i][lastNonSpace + 1] = '\0';
        } else {
            result[i][0] = '\0';
        }
    }

    *returnSize = maxLen;
    return result;
}