int maximumLengthOfValidSubstring(char * s) {
    int n = strlen(s);
    int maxLength = 0, currentLength = 0, balance = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'a') {
            balance++;
        } else if (s[i] == 'b') {
            balance--;
        }

        if (balance < 0) {
            currentLength = 0;
            balance = 0;
        } else {
            currentLength++;
            if (balance == 0) {
                maxLength = fmax(maxLength, currentLength);
            }
        }
    }

    balance = 0;
    currentLength = 0;

    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == 'a') {
            balance++;
        } else if (s[i] == 'b') {
            balance--;
        }

        if (balance < 0) {
            currentLength = 0;
            balance = 0;
        } else {
            currentLength++;
            if (balance == 0) {
                maxLength = fmax(maxLength, currentLength);
            }
        }
    }

    return maxLength;
}