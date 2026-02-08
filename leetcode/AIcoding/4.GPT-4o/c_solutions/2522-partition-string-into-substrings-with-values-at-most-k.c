int partitionString(char * s, int k){
    int count = 0;
    int currentValue = 0;
    int seen[10] = {0};

    for (int i = 0; s[i] != '\0'; i++) {
        int digit = s[i] - '0';
        if (seen[digit] == 0) {
            seen[digit] = 1;
            currentValue++;
        } else {
            count++;
            memset(seen, 0, sizeof(seen));
            seen[digit] = 1;
            currentValue = 1;
        }

        if (currentValue == k) {
            count++;
            memset(seen, 0, sizeof(seen));
            currentValue = 0;
        }
    }

    return count + (currentValue > 0 ? 1 : 0);
}