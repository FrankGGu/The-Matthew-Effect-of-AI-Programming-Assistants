#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *decodeMessage(char *key, char *message) {
    char mapping[26] = {0};
    int count = 0;
    for (int i = 0; key[i] != '\0'; i++) {
        if (key[i] != ' ' && mapping[key[i] - 'a'] == 0) {
            mapping[key[i] - 'a'] = 'a' + count;
            count++;
        }
    }

    char *decoded = (char *)malloc(strlen(message) + 1);
    if (decoded == NULL) {
        return NULL;
    }

    for (int i = 0; message[i] != '\0'; i++) {
        if (message[i] == ' ') {
            decoded[i] = ' ';
        } else {
            decoded[i] = mapping[message[i] - 'a'];
        }
    }
    decoded[strlen(message)] = '\0';

    return decoded;
}