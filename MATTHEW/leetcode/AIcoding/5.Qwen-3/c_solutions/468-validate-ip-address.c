#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_LEN 16

char* validIPAddress(char* queryIP) {
    int len = strlen(queryIP);
    if (len > MAX_LEN) return "Neither";

    int dot_count = 0;
    int hex_count = 0;
    int is_ipv4 = 1;
    int is_ipv6 = 1;

    for (int i = 0; i < len; i++) {
        if (queryIP[i] == '.') {
            dot_count++;
            if (dot_count > 3) return "Neither";
            is_ipv6 = 0;
        } else if (queryIP[i] == ':') {
            hex_count++;
            if (hex_count > 7) return "Neither";
            is_ipv4 = 0;
        }
    }

    if (is_ipv4) {
        char* token = strtok(queryIP, ".");
        int count = 0;
        while (token != NULL) {
            count++;
            if (count > 4) return "Neither";
            if (strlen(token) == 0 || strlen(token) > 3) return "Neither";
            for (int i = 0; i < strlen(token); i++) {
                if (!isdigit(token[i])) return "Neither";
            }
            int num = atoi(token);
            if (num < 0 || num > 255) return "Neither";
            if (strlen(token) > 1 && token[0] == '0') return "Neither";
            token = strtok(NULL, ".");
        }
        if (count != 4) return "Neither";
        return "IPv4";
    } else if (is_ipv6) {
        char* token = strtok(queryIP, ":");
        int count = 0;
        while (token != NULL) {
            count++;
            if (count > 8) return "Neither";
            if (strlen(token) == 0 || strlen(token) > 4) return "Neither";
            for (int i = 0; i < strlen(token); i++) {
                if (!isalnum(token[i])) return "Neither";
            }
            token = strtok(NULL, ":");
        }
        if (count != 8) return "Neither";
        return "IPv6";
    } else {
        return "Neither";
    }
}