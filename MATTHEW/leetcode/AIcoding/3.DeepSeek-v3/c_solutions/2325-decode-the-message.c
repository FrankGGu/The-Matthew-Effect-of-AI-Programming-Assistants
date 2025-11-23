char* decodeMessage(char* key, char* message) {
    char mapping[26];
    for (int i = 0; i < 26; i++) {
        mapping[i] = 0;
    }

    char current_char = 'a';
    for (int i = 0; key[i] != '\0'; i++) {
        if (key[i] != ' ' && mapping[key[i] - 'a'] == 0) {
            mapping[key[i] - 'a'] = current_char;
            current_char++;
        }
    }

    for (int i = 0; message[i] != '\0'; i++) {
        if (message[i] != ' ') {
            message[i] = mapping[message[i] - 'a'];
        }
    }

    return message;
}