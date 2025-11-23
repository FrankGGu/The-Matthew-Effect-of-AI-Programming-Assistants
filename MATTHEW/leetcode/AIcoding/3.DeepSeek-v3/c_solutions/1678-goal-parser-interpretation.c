char* interpret(char* command) {
    int len = strlen(command);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int i = 0, j = 0;

    while (command[i]) {
        if (command[i] == 'G') {
            result[j++] = 'G';
            i++;
        } else if (command[i] == '(' && command[i+1] == ')') {
            result[j++] = 'o';
            i += 2;
        } else {
            result[j++] = 'a';
            result[j++] = 'l';
            i += 4;
        }
    }

    result[j] = '\0';
    return result;
}