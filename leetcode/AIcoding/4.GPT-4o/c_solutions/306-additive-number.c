bool isAdditiveNumber(char * num) {
    int len = strlen(num);
    for (int i = 1; i < len; i++) {
        for (int j = i + 1; j < len; j++) {
            if ((num[0] == '0' && i > 1) || (num[i] == '0' && j - i > 1)) continue;
            long long first = atoll(strndup(num, i));
            long long second = atoll(strndup(num + i, j - i));
            char *ptr = num + j;
            while (ptr - num < len) {
                long long sum = first + second;
                char sumStr[20];
                sprintf(sumStr, "%lld", sum);
                int sumLen = strlen(sumStr);
                if (strncmp(ptr, sumStr, sumLen) != 0) break;
                ptr += sumLen;
                first = second;
                second = sum;
            }
            if (ptr - num == len) return true;
        }
    }
    return false;
}