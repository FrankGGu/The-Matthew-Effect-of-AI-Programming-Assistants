int countValidNumbers(char * s) {
    int len = strlen(s);
    int count = 0;

    for (int i = 1; i <= len / 2; i++) {
        long long firstNum = atoll(strndup(s, i));
        long long curNum = firstNum;
        char *ptr = s + i;
        int valid = 1;

        while (ptr < s + len) {
            curNum++;
            char buffer[20];
            sprintf(buffer, "%lld", curNum);
            int bufferLen = strlen(buffer);
            if (strncmp(ptr, buffer, bufferLen) != 0) {
                valid = 0;
                break;
            }
            ptr += bufferLen;
        }

        if (valid && ptr == s + len) {
            count++;
        }
    }

    return count;
}