char * interpret(char * command) {
    int len = strlen(command);
    char *result = (char *)malloc(len * 2 + 1);
    int j = 0;

    for (int i = 0; i < len; i++) {
        if (command[i] == 'G') {
            result[j++] = 'G';
        } else if (command[i] == '(') {
            if (command[i + 1] == ')') {
                result[j++] = 'o';
                i++; 
            } else {
                result[j++] = 'a';
                result[j++] = 'l';
                i += 3; 
            }
        }
    }

    result[j] = '\0';
    return result;
}