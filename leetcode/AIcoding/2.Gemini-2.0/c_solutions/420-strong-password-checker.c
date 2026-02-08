#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strongPasswordChecker(char * password) {
    int len = strlen(password);
    int missing = 0;
    if (strchr(password, '0') == NULL && strchr(password, '1') == NULL && strchr(password, '2') == NULL && strchr(password, '3') == NULL && strchr(password, '4') == NULL && strchr(password, '5') == NULL && strchr(password, '6') == NULL && strchr(password, '7') == NULL && strchr(password, '8') == NULL && strchr(password, '9') == NULL) missing++;
    if (strchr(password, 'a') == NULL && strchr(password, 'b') == NULL && strchr(password, 'c') == NULL && strchr(password, 'd') == NULL && strchr(password, 'e') == NULL && strchr(password, 'f') == NULL && strchr(password, 'g') == NULL && strchr(password, 'h') == NULL && strchr(password, 'i') == NULL && strchr(password, 'j') == NULL && strchr(password, 'k') == NULL && strchr(password, 'l') == NULL && strchr(password, 'm') == NULL && strchr(password, 'n') == NULL && strchr(password, 'o') == NULL && strchr(password, 'p') == NULL && strchr(password, 'q') == NULL && strchr(password, 'r') == NULL && strchr(password, 's') == NULL && strchr(password, 't') == NULL && strchr(password, 'u') == NULL && strchr(password, 'v') == NULL && strchr(password, 'w') == NULL && strchr(password, 'x') == NULL && strchr(password, 'y') == NULL && strchr(password, 'z') == NULL) missing++;
    if (strchr(password, 'A') == NULL && strchr(password, 'B') == NULL && strchr(password, 'C') == NULL && strchr(password, 'D') == NULL && strchr(password, 'E') == NULL && strchr(password, 'F') == NULL && strchr(password, 'G') == NULL && strchr(password, 'H') == NULL && strchr(password, 'I') == NULL && strchr(password, 'J') == NULL && strchr(password, 'K') == NULL && strchr(password, 'L') == NULL && strchr(password, 'M') == NULL && strchr(password, 'N') == NULL && strchr(password, 'O') == NULL && strchr(password, 'P') == NULL && strchr(password, 'Q') == NULL && strchr(password, 'R') == NULL && strchr(password, 'S') == NULL && strchr(password, 'T') == NULL && strchr(password, 'U') == NULL && strchr(password, 'V') == NULL && strchr(password, 'W') == NULL && strchr(password, 'X') == NULL && strchr(password, 'Y') == NULL && strchr(password, 'Z') == NULL) missing++;

    int res = 0;
    if (len < 6) {
        res = fmax(missing, 6 - len);
    } else if (len > 20) {
        int over = len - 20;
        res += over;
        int one = 0, two = 0, three = 0;
        for (int i = 0; i < len;) {
            int j = i;
            while (j < len && password[j] == password[i]) j++;
            int repeat = j - i;
            if (repeat >= 3) {
                if (repeat % 3 == 0) one++;
                else if (repeat % 3 == 1) two++;
                else three++;
            }
            i = j;
        }

        if (over <= one) {
            res -= over;
        } else {
            res -= one;
            over -= one;
            if (over <= two * 2) {
                res -= over / 2;
            } else {
                res -= two;
                over -= two * 2;
                res -= over / 3;
            }
        }
        res += fmax(missing, 0);
    } else {
        int repeat = 0;
        for (int i = 0; i < len;) {
            int j = i;
            while (j < len && password[j] == password[i]) j++;
            if (j - i >= 3) repeat += (j - i) / 3;
            i = j;
        }
        res = fmax(missing, repeat);
    }
    return res;
}