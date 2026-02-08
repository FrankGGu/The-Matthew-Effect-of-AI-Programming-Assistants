#include <stdlib.h>
#include <string.h>

char* findEncryptedString(char* s, int k) {
    int n = strlen(s);
    char* encrypted_s = (char*)malloc(sizeof(char) * (n + 1));
    for (int i = 0; i < n; i++) {
        encrypted_s[i] = s[(i + k) % n];
    }
    encrypted_s[n] = '\0';
    return encrypted_s;
}