char * decodeMessage(char * key, char * message) {
    char *result = malloc(strlen(message) + 1);
    int mapping[26] = {0};
    char currentChar = 'a';

    for (int i = 0; key[i] != '\0'; i++) {
        if (key[i] != ' ' && mapping[key[i] - 'a'] == 0) {
            mapping[key[i] - 'a'] = currentChar++;
        }
    }

    for (int i = 0; message[i] != '\0'; i++) {
        if (message[i] == ' ') {
            result[i] = ' ';
        } else {
            result[i] = mapping[message[i] - 'a'];
        }
    }

    result[strlen(message)] = '\0';
    return result;
}