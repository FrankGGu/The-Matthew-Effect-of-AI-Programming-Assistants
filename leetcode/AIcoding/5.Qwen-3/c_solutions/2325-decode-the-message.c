#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* createMessage(char* key, char* message) {
    int keyLen = strlen(key);
    int msgLen = strlen(message);
    char* result = (char*)malloc((msgLen + 1) * sizeof(char));
    int index = 0;
    int keyIndex = 0;
    int map[26] = {0};
    int used[26] = {0};

    for (int i = 0; i < keyLen; i++) {
        char c = key[i];
        if (c == ' ') continue;
        if (!used[c - 'a']) {
            map[c - 'a'] = index++;
            used[c - 'a'] = 1;
        }
    }

    for (int i = 0; i < msgLen; i++) {
        char c = message[i];
        if (c == ' ') {
            result[i] = ' ';
            continue;
        }
        int pos = c - 'a';
        if (pos >= 0 && pos < 26 && used[pos]) {
            result[i] = 'a' + map[pos];
        } else {
            result[i] = c;
        }
    }
    result[msgLen] = '\0';
    return result;
}

char* decodeMessage(char* key, char* message) {
    return createMessage(key, message);
}