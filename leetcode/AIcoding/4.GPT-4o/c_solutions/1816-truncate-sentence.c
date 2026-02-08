char *truncateSentence(char *s, int k) {
    char *result = malloc(200 * sizeof(char));
    int count = 0, i = 0, j = 0;

    while (s[i] != '\0' && count < k) {
        if (s[i] == ' ') {
            count++;
        }
        if (count < k) {
            result[j++] = s[i];
        }
        i++;
    }
    result[j] = '\0';
    return result;
}