#include <stdbool.h>

bool isNumber(char *s) {
    int i = 0;
    bool digitSeen = false;
    bool dotSeen = false;
    bool eSeen = false;

    while (s[i] == ' ') {
        i++;
    }

    if (s[i] == '+' || s[i] == '-') {
        i++;
    }

    while (s[i] != '\0') {
        if (s[i] >= '0' && s[i] <= '9') {
            digitSeen = true;
        } else if (s[i] == '.') {
            if (dotSeen || eSeen) {
                return false;
            }
            dotSeen = true;
        } else if (s[i] == 'e' || s[i] == 'E') {
            if (eSeen || !digitSeen) {
                return false;
            }
            eSeen = true;
            digitSeen = false; 

            i++;
            if (s[i] == '+' || s[i] == '-') {
                i++;
            }

            while (s[i] >= '0' && s[i] <= '9') {
                digitSeen = true;
                i++;
            }
            break; 
        } else if (s[i] == ' ') {
            break; 
        } else {
            return false; 
        }
        i++;
    }

    if (!digitSeen) {
        return false;
    }

    while (s[i] == ' ') {
        i++;
    }

    return s[i] == '\0';
}