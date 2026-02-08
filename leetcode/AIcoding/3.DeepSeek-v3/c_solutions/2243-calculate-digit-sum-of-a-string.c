char * digitSum(char * s, int k){
    while (strlen(s) > k) {
        int len = strlen(s);
        char *temp = (char *)malloc(sizeof(char) * (len + 1));
        int temp_idx = 0;

        for (int i = 0; i < len; i += k) {
            int sum = 0;
            for (int j = i; j < i + k && j < len; j++) {
                sum += s[j] - '0';
            }

            char buffer[20];
            sprintf(buffer, "%d", sum);
            for (int j = 0; j < strlen(buffer); j++) {
                temp[temp_idx++] = buffer[j];
            }
        }
        temp[temp_idx] = '\0';
        strcpy(s, temp);
        free(temp);
    }
    return s;
}