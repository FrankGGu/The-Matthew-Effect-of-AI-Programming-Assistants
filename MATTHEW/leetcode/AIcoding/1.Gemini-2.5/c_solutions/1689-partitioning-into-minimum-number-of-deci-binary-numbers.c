int minPartitions(char * n){
    int max_digit = 0;
    for (int i = 0; n[i] != '\0'; i++) {
        int current_digit = n[i] - '0';
        if (current_digit > max_digit) {
            max_digit = current_digit;
        }
    }
    return max_digit;
}