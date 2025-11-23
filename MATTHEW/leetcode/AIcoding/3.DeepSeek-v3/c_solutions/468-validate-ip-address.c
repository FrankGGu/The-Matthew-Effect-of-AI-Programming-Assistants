#include <ctype.h>
#include <string.h>
#include <stdbool.h>

bool isIPv4(char* queryIP) {
    int num = 0;
    int count = 0;
    int digits = 0;

    for (int i = 0; queryIP[i]; i++) {
        if (queryIP[i] == '.') {
            if (digits == 0 || num < 0 || num > 255) return false;
            count++;
            num = 0;
            digits = 0;
        } else if (isdigit(queryIP[i])) {
            if (digits > 0 && num == 0) return false;
            num = num * 10 + (queryIP[i] - '0');
            digits++;
            if (digits > 3) return false;
        } else {
            return false;
        }
    }

    if (count != 3 || digits == 0 || num < 0 || num > 255) return false;
    return true;
}

bool isIPv6(char* queryIP) {
    int count = 0;
    int chars = 0;

    for (int i = 0; queryIP[i]; i++) {
        if (queryIP[i] == ':') {
            if (chars == 0 || chars > 4) return false;
            count++;
            chars = 0;
        } else if (isxdigit(queryIP[i])) {
            chars++;
            if (chars > 4) return false;
        } else {
            return false;
        }
    }

    if (count != 7 || chars == 0 || chars > 4) return false;
    return true;
}

char* validIPAddress(char* queryIP) {
    if (strchr(queryIP, '.')) {
        if (isIPv4(queryIP)) return "IPv4";
    } else if (strchr(queryIP, ':')) {
        if (isIPv6(queryIP)) return "IPv6";
    }
    return "Neither";
}