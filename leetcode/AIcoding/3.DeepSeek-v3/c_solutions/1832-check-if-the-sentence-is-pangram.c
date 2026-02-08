bool checkIfPangram(char* sentence) {
    int seen = 0;
    for (int i = 0; sentence[i] != '\0'; i++) {
        seen |= 1 << (sentence[i] - 'a');
    }
    return seen == (1 << 26) - 1;
}