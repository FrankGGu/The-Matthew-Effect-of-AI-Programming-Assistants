int balancedStringSplit(char * s){
    int balance = 0;
    int count = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'L') {
            balance++;
        } else {
            balance--;
        }
        if (balance == 0) {
            count++;
        }
    }
    return count;
}