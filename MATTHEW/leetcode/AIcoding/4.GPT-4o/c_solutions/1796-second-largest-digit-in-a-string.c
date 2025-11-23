int secondHighest(char * s){
    int first = -1, second = -1;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            int digit = s[i] - '0';
            if (digit > first) {
                second = first;
                first = digit;
            } else if (digit > second && digit < first) {
                second = digit;
            }
        }
    }
    return second;
}