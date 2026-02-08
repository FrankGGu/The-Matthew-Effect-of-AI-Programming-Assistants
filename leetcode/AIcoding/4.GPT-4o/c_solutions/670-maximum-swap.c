int maximumSwap(int num) {
    int last[10];
    for (int i = 0; i < 10; i++) last[i] = -1;

    char str[10];
    sprintf(str, "%d", num);

    for (int i = 0; str[i]; i++) {
        last[str[i] - '0'] = i;
    }

    for (int i = 0; str[i]; i++) {
        for (int d = 9; d > str[i] - '0'; d--) {
            if (last[d] > i) {
                char temp = str[i];
                str[i] = str[last[d]];
                str[last[d]] = temp;
                return atoi(str);
            }
        }
    }
    return num;
}