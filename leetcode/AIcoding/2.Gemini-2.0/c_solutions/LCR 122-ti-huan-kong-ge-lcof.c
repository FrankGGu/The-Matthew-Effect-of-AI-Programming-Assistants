#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *encryptPath(char *path, int shift) {
    int len = strlen(path);
    char *encryptedPath = (char *)malloc(len + 1);
    if (encryptedPath == NULL) {
        return NULL;
    }

    for (int i = 0; i < len; i++) {
        if (path[i] >= 'a' && path[i] <= 'z') {
            encryptedPath[i] = 'a' + (path[i] - 'a' + shift) % 26;
        } else if (path[i] >= 'A' && path[i] <= 'Z') {
            encryptedPath[i] = 'A' + (path[i] - 'A' + shift) % 26;
        } else if (path[i] >= '0' && path[i] <= '9') {
            encryptedPath[i] = '0' + (path[i] - '0' + shift) % 10;
        } else {
            encryptedPath[i] = path[i];
        }
    }
    encryptedPath[len] = '\0';

    return encryptedPath;
}