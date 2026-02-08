int countSeniors(char ** details, int detailsSize){
    int seniorCount = 0;
    for (int i = 0; i < detailsSize; i++) {
        char *s = details[i];
        // Age is at index 11 and 12 (0-indexed)
        int age = (s[11] - '0') * 10 + (s[12] - '0');
        if (age > 60) {
            seniorCount++;
        }
    }
    return seniorCount;
}