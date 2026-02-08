char* digitSum(char* s, int k) {
    int len = strlen(s);
    char* temp = (char*)malloc((len + 1) * sizeof(char));
    strcpy(temp, s);

    while (strlen(temp) > k) {
        int newLen = 0;
        int sum = 0;
        int count = 0;

        for (int i = 0; temp[i] != '\0'; i++) {
            sum += temp[i] - '0';
            count++;

            if (count == k || temp[i + 1] == '\0') {
                if (sum >= 10) {
                    temp[newLen++] = (sum / 10) + '0';
                    temp[newLen++] = (sum % 10) + '0';
                } else {
                    temp[newLen++] = sum + '0';
                }
                sum = 0;
                count = 0;
            }
        }
        temp[newLen] = '\0';
    }

    return temp;
}

bool hasSameDigits(char* s) {
    char* result = digitSum(s, 2);
    int len = strlen(result);
    for (int i = 1; i < len; i++) {
        if (result[i] != result[0]) {
            return false;
        }
    }
    return true;
}