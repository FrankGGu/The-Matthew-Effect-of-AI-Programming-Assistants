int longestCommonPrefix(char ** strs, int strsSize) {
    if (strsSize == 0) return 0;
    int prefixLength = 0;
    while (1) {
        char currentChar = strs[0][prefixLength];
        for (int i = 1; i < strsSize; i++) {
            if (strs[i][prefixLength] != currentChar || strs[i][prefixLength] == '\0') {
                return prefixLength;
            }
        }
        prefixLength++;
    }
}