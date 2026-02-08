char* defangIPaddr(char* address) {
    char* result = malloc(1000);
    int i = 0, j = 0;
    while (address[i]) {
        if (address[i] == '.') {
            result[j++] = '[';
            result[j++] = '.';
            result[j++] = ']';
        } else {
            result[j++] = address[i];
        }
        i++;
    }
    result[j] = '\0';
    return result;
}