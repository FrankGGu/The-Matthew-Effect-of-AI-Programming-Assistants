#include <stdlib.h>
#include <string.h>

char* decodeMessage(char* key, char* message) {
    char mapping[128] = {0}; 
    char current_map_char = 'a';

    for (int i = 0; key[i] != '\0'; i++) {
        char c = key[i];
        if (c >= 'a' && c <= 'z' && mapping[c] == 0) {
            mapping[c] = current_map_char;
            current_map_char++;
        }
    }

    int message_len = strlen(message);
    char* decoded_message = (char*)malloc(sizeof(char) * (message_len + 1));

    for (int i = 0; i < message_len; i++) {
        char c = message[i];
        if (c == ' ') {
            decoded_message[i] = ' ';
        } else {
            decoded_message[i] = mapping[c];
        }
    }

    decoded_message[message_len] = '\0';

    return decoded_message;
}