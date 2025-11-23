#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValidEmail(const char *email) {
    if (email == NULL || *email == '\0') {
        return false;
    }

    int len = strlen(email);
    int atIndex = -1;
    int dotIndex = -1;

    for (int i = 0; i < len; i++) {
        if (email[i] == '@') {
            if (atIndex != -1) {
                return false;
            }
            atIndex = i;
        } else if (email[i] == '.') {
            dotIndex = i;
        }
    }

    if (atIndex == -1 || dotIndex == -1 || atIndex > dotIndex) {
        return false;
    }

    if (atIndex == 0 || dotIndex == len - 1) {
        return false;
    }

    for (int i = 0; i < len; i++) {
        if (!((email[i] >= 'a' && email[i] <= 'z') ||
              (email[i] >= 'A' && email[i] <= 'Z') ||
              (email[i] >= '0' && email[i] <= '9') ||
              email[i] == '_' || email[i] == '.' || email[i] == '@')) {
            return false;
        }
    }

    return true;
}