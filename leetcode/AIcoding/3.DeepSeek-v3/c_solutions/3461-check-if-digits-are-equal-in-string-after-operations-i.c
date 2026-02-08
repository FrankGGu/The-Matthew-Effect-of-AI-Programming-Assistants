char* digitSum(char* s, int k) {
    int len = strlen(s);
    char* temp = (char*)malloc((len + 1) * sizeof(char));

    while (len > k) {
        int idx = 0;
        for (int i = 0; i < len; i += k) {
            int sum = 0;
            for (int j = i; j < i + k && j < len; j++) {
                sum += s[j] - '0';
            }
            if (sum < 10) {
                temp[idx++] = sum + '0';
            } else {
                sprintf(temp + idx, "%d", sum);
                idx += strlen(temp + idx);
            }
        }
        temp[idx] = '\0';
        len = idx;
        strcpy(s, temp);
    }

    free(temp);
    return s;
}

bool hasSameDigits(char* s) {
    int len = strlen(s);
    if (len <= 1) return true;

    char first = s[0];
    for (int i = 1; i < len; i++) {
        if (s[i] != first) {
            return false;
        }
    }
    return true;
}