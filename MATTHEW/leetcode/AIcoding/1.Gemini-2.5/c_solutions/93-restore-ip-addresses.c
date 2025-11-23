#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define MAX_IP_ADDR_LEN 16
#define INITIAL_CAPACITY 16

static int parse_int(char *s, int start, int len) {
    int num = 0;
    for (int i = 0; i < len; i++) {
        num = num * 10 + (s[start + i] - '0');
    }
    return num;
}

static void backtrack(char *s, int s_len, int start_idx, int part_idx, char current_ip_parts[4][4], char ***result, int *returnSize, int *capacity) {
    if (part_idx == 4) {
        if (start_idx == s_len) {
            char *ip_addr = (char *)malloc(sizeof(char) * MAX_IP_ADDR_LEN);
            sprintf(ip_addr, "%s.%s.%s.%s", current_ip_parts[0], current_ip_parts[1], current_ip_parts[2], current_ip_parts[3]);

            if (*returnSize == *capacity) {
                *capacity *= 2;
                *result = (char **)realloc(*result, sizeof(char *) * (*capacity));
            }
            (*result)[(*returnSize)++] = ip_addr;
        }
        return;
    }

    if (start_idx == s_len) {
        return;
    }

    int remaining_parts = 4 - part_idx;
    int remaining_chars = s_len - start_idx;
    if (remaining_chars < remaining_parts * 1 || remaining_chars > remaining_parts * 3) {
        return;
    }

    for (int len = 1; len <= 3; len++) {
        int end_idx = start_idx + len - 1;

        if (end_idx >= s_len) {
            break;
        }

        if (len > 1 && s[start_idx] == '0') {
            continue;
        }

        int val = parse_int(s, start_idx, len);

        if (val >= 0 && val <= 255) {
            strncpy(current_ip_parts[part_idx], s + start_idx, len);
            current_ip_parts[part_idx][len] = '\0';

            backtrack(s, s_len, end_idx + 1, part_idx + 1, current_ip_parts, result, returnSize, capacity);
        }
    }
}

char **restoreIpAddresses(char *s, int *returnSize) {
    *returnSize = 0;
    int capacity = INITIAL_CAPACITY;
    char **result = (char **)malloc(sizeof(char *) * capacity);
    if (!result) return NULL;

    int s_len = strlen(s);

    char current_ip_parts[4][4];

    backtrack(s, s_len, 0, 0, current_ip_parts, &result, returnSize, &capacity);

    if (*returnSize < capacity) {
        result = (char **)realloc(result, sizeof(char *) * (*returnSize));
    }

    return result;
}