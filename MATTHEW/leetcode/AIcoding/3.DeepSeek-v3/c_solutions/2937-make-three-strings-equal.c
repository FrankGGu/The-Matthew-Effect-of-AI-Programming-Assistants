int findMinimumOperations(char* s1, char* s2, char* s3) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int len3 = strlen(s3);

    int min_len = len1;
    if (len2 < min_len) min_len = len2;
    if (len3 < min_len) min_len = len3;

    int common = 0;
    for (int i = 0; i < min_len; i++) {
        if (s1[i] == s2[i] && s2[i] == s3[i]) {
            common++;
        } else {
            break;
        }
    }

    if (common == 0) return -1;

    return (len1 - common) + (len2 - common) + (len3 - common);
}