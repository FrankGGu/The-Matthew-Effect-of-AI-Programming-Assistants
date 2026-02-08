char * interpret(char * command) {
    int len = strlen(command);
    char *result = (char *)malloc(len * 2 + 1);
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (command[i] == 'G') {
            result[index++] = 'G';
        } else if (command[i] == '(') {
            if (command[i + 1] == ')') {
                result[index++] = 'o';
                i++;
            } else if (command[i + 1] == 'a') {
                result[index++] = 'a';
                result[index++] = 'l';
                i += 3; // Skip over "al)"
            }
        }
    }
    result[index] = '\0';
    return result;
}