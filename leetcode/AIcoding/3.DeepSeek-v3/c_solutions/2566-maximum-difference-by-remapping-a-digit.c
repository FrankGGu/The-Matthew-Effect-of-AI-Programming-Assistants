int minMaxDifference(int num) {
    char str[10];
    sprintf(str, "%d", num);
    int len = strlen(str);

    char max_char = '9';
    for (int i = 0; i < len; i++) {
        if (str[i] != '9') {
            max_char = str[i];
            break;
        }
    }

    char min_char = str[0];

    long max_val = 0, min_val = 0;
    for (int i = 0; i < len; i++) {
        max_val = max_val * 10 + (str[i] == max_char ? 9 : (str[i] - '0'));
        min_val = min_val * 10 + (str[i] == min_char ? 0 : (str[i] - '0'));
    }

    return max_val - min_val;
}