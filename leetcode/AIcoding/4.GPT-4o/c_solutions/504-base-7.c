char* convertToBase7(int num) {
    if(num == 0) return "0";
    int negative = num < 0;
    num = negative ? -num : num;
    char buffer[20];
    int index = 0;
    while(num > 0) {
        buffer[index++] = (num % 7) + '0';
        num /= 7;
    }
    if(negative) buffer[index++] = '-';
    buffer[index] = '\0';
    char* result = (char*)malloc(index + 1);
    for(int i = 0; i < index; i++) {
        result[i] = buffer[index - 1 - i];
    }
    result[index] = '\0';
    return result;
}