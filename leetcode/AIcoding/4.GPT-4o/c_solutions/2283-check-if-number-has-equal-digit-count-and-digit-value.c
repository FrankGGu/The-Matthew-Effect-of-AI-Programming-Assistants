bool digitCount(char * num) {
    int count[10] = {0};
    int length = strlen(num);

    for (int i = 0; i < length; i++) {
        count[num[i] - '0']++;
    }

    for (int i = 0; i < length; i++) {
        if (count[i] != num[i] - '0') {
            return false;
        }
    }

    return true;
}