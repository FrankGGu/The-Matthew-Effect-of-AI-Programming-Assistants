char findKthCharacter(char * s, int k) {
    int length = strlen(s);
    int totalLength = 0;
    int n = 1;

    while (totalLength + n < k) {
        totalLength += n;
        n++;
    }

    int index = k - totalLength - 1;
    return s[index % length];
}