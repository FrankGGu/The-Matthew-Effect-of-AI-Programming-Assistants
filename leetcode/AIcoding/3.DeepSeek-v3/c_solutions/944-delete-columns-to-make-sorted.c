int minDeletionSize(char ** strs, int strsSize){
    int n = strlen(strs[0]);
    int count = 0;

    for (int j = 0; j < n; j++) {
        for (int i = 1; i < strsSize; i++) {
            if (strs[i][j] < strs[i-1][j]) {
                count++;
                break;
            }
        }
    }

    return count;
}