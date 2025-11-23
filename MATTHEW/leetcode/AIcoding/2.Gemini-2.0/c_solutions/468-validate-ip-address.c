#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isValidIPv4(char *IP) {
    int count = 0;
    char *token = strtok(IP, ".");
    while (token != NULL) {
        count++;
        int num = atoi(token);
        if (num < 0 || num > 255) return 0;
        if (strlen(token) > 1 && token[0] == '0') return 0;

        int len = strlen(token);
        for(int i = 0; i < len; i++){
            if(token[i] < '0' || token[i] > '9') return 0;
        }

        token = strtok(NULL, ".");
    }
    return count == 4;
}

int isValidIPv6(char *IP) {
    int count = 0;
    char *token = strtok(IP, ":");
    while (token != NULL) {
        count++;
        if (strlen(token) > 4) return 0;

        int len = strlen(token);
        for(int i = 0; i < len; i++){
            if(!((token[i] >= '0' && token[i] <= '9') || (token[i] >= 'a' && token[i] <= 'f') || (token[i] >= 'A' && token[i] <= 'F'))) return 0;
        }

        token = strtok(NULL, ":");
    }
    return count == 8;
}

char *validIPAddress(char *IP) {
    char *IP_copy = strdup(IP);
    if (strchr(IP, '.') != NULL) {
        if (isValidIPv4(IP_copy)) {
            free(IP_copy);
            return "IPv4";
        }
    } else if (strchr(IP, ':') != NULL) {
        free(IP_copy);
        IP_copy = strdup(IP);
        if (isValidIPv6(IP_copy)) {
            free(IP_copy);
            return "IPv6";
        }
    }
    free(IP_copy);
    return "Neither";
}