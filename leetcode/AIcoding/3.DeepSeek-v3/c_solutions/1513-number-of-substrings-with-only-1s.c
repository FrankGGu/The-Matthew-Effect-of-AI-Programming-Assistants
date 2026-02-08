int numSub(char* s) {
    long count = 0;
    long consecutive = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '1') {
            consecutive++;
            count += consecutive;
        } else {
            consecutive = 0;
        }
    }

    return count % 1000000007;
}