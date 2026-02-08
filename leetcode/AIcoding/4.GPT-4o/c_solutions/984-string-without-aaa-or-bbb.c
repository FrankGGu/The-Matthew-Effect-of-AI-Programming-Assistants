char * strWithoutAAAorBBB(int A, int B) {
    char *result = (char *)malloc((A + B + 1) * sizeof(char));
    int index = 0;
    while (A > 0 || B > 0) {
        if (A > B) {
            if (A > 0) {
                result[index++] = 'a';
                A--;
            }
            if (A > 0) {
                result[index++] = 'a';
                A--;
            }
            if (B > 0) {
                result[index++] = 'b';
                B--;
            }
        } else {
            if (B > 0) {
                result[index++] = 'b';
                B--;
            }
            if (B > 0) {
                result[index++] = 'b';
                B--;
            }
            if (A > 0) {
                result[index++] = 'a';
                A--;
            }
        }
    }
    result[index] = '\0';
    return result;
}