int minSwaps(char* s) {
    int balance = 0;
    int swaps = 0;
    int j = strlen(s) - 1;

    for (int i = 0; i < j; i++) {
        if (s[i] == '[') {
            balance++;
        } else {
            balance--;
        }

        if (balance < 0) {
            while (i < j && s[j] != '[') {
                j--;
            }
            swaps++;
            balance = 1;
            j--;
        }
    }

    return swaps;
}