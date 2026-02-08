int secondHighest(char * s){
    int max1 = -1; // Stores the largest digit found
    int max2 = -1; // Stores the second largest digit found

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            int digit = s[i] - '0';

            if (digit > max1) {
                max2 = max1;
                max1 = digit;
            } else if (digit < max1 && digit > max2) {
                max2 = digit;
            }
        }
    }

    return max2;
}