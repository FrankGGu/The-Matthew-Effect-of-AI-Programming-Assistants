bool digitCount(char* num) {
    int count[10] = {0};
    int len = strlen(num);

    for (int i = 0; i < len; i++) {
        count[num[i] - '0']++;
    }

    for (int i = 0; i < len; i++) {
        if (count[i] != (num[i] - '0')) {
            return false;
        }
    }

    return true;
}