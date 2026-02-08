/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** cellsInRange(char * s, int* returnSize){
    char col1 = s[0];
    char col2 = s[3];
    char row1 = s[1];
    char row2 = s[4];

    int cols = col2 - col1 + 1;
    int rows = row2 - row1 + 1;
    *returnSize = cols * rows;

    char **result = (char **)malloc(*returnSize * sizeof(char *));
    int index = 0;

    for (char c = col1; c <= col2; c++) {
        for (char r = row1; r <= row2; r++) {
            result[index] = (char *)malloc(3 * sizeof(char));
            result[index][0] = c;
            result[index][1] = r;
            result[index][2] = '\0';
            index++;
        }
    }

    return result;
}