char* removeDigit(char* number, char digit) {
    int len = strlen(number);
    char* result = (char*)malloc(len * sizeof(char));
    int last_occurrence = -1;

    for (int i = 0; i < len; i++) {
        if (number[i] == digit) {
            last_occurrence = i;
            if (i < len - 1 && number[i] < number[i + 1]) {
                strncpy(result, number, i);
                strcpy(result + i, number + i + 1);
                return result;
            }
        }
    }

    strncpy(result, number, last_occurrence);
    strcpy(result + last_occurrence, number + last_occurrence + 1);
    return result;
}