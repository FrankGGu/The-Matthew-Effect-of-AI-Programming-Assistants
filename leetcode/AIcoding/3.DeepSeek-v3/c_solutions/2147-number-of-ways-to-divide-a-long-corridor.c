int numberOfWays(char* corridor) {
    int mod = 1e9 + 7;
    int seats = 0;
    int plants = 0;
    long result = 1;

    for (int i = 0; corridor[i] != '\0'; i++) {
        if (corridor[i] == 'S') {
            seats++;
            if (seats > 2 && seats % 2 == 1) {
                result = (result * (plants + 1)) % mod;
            }
            plants = 0;
        } else {
            if (seats >= 2 && seats % 2 == 0) {
                plants++;
            }
        }
    }

    return (seats >= 2 && seats % 2 == 0) ? result : 0;
}