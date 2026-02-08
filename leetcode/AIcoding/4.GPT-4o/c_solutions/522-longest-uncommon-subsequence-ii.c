int findLUSlength(char **strs, int strsSize) {
    int maxLength = -1;

    for (int i = 0; i < strsSize; i++) {
        int isSubseq = 0;
        for (int j = 0; j < strsSize; j++) {
            if (i != j) {
                int k = 0, l = 0;
                while (k < strlen(strs[i]) && l < strlen(strs[j])) {
                    if (strs[i][k] == strs[j][l]) {
                        k++;
                    }
                    l++;
                }
                if (k == strlen(strs[i])) {
                    isSubseq = 1;
                    break;
                }
            }
        }
        if (!isSubseq) {
            maxLength = fmax(maxLength, strlen(strs[i]));
        }
    }

    return maxLength;
}