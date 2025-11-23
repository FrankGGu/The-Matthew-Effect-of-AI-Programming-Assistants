#include <stdlib.h>
#include <string.h>

char** result_ips;
int result_count;
int result_capacity;

int is_valid_segment(char* s, int start, int end) {
    int len = end - start + 1;
    if (len == 0 || len > 3) {
        return 0;
    }
    if (len > 1 && s[start] == '0') {
        return 0;
    }

    int num = 0;
    for (int i = start; i <= end; i++) {
        num = num * 10 + (s[i] - '0');
    }

    return num >= 0 && num <= 255;
}

void add_to_result(char* ip_str) {
    if (result_count == result_capacity) {
        result_capacity = result_capacity == 0 ? 1 : result_capacity * 2;
        result_ips = (char**)realloc(result_ips, result_capacity * sizeof(char*));
    }
    result_ips[result_count] = (char*)malloc(strlen(ip_str) + 1);
    strcpy(result_ips[result_count], ip_str);
    result_count++;
}

void backtrack(char* s, int start_idx, int segment_count, char* current_ip_buffer, int* current_ip_buffer_len_ptr) {
    int n = strlen(s);
    int current_ip_buffer_len = *current_ip_buffer_len_ptr;

    if (segment_count == 4) {
        if (start_idx == n) {
            current_ip_buffer[current_ip_buffer_len] = '\0';
            add_to_result(current_ip_buffer);
        }
        return;
    }

    int remaining_segments = 4 - segment_count;
    int remaining_chars = n - start_idx;
    if (remaining_chars < remaining_segments || remaining_chars > remaining_segments * 3) {
        return;
    }

    for (int i = start_idx; i < start_idx + 3 && i < n; i++) {
        if (is_valid_segment(s, start_idx, i)) {
            int prev_buffer_len = current_ip_buffer_len;

            for (int j = start_idx; j <= i; j++) {
                current_ip_buffer[current_ip_buffer_len++] = s[j];
            }
            if (segment_count < 3) {
                current_ip_buffer[current_ip_buffer_len++] = '.';
            }

            *current_ip_buffer_len_ptr = current_ip_buffer_len;

            backtrack(s, i + 1, segment_count + 1, current_ip_buffer, current_ip_buffer_len_ptr);

            *current_ip_buffer_len_ptr = prev_buffer_len;
            current_ip_buffer_len = prev_buffer_len;
        }
    }
}

char** restoreIpAddresses(char* s, int* returnSize) {
    if (result_ips != NULL) {
        for (int i = 0; i < result_count; i++) {
            free(result_ips[i]);
        }
        free(result_ips);
    }
    result_ips = NULL;
    result_count = 0;
    result_capacity = 0;

    char current_ip_buffer[20];
    int current_ip_buffer_len = 0;

    backtrack(s, 0, 0, current_ip_buffer, &current_ip_buffer_len);

    *returnSize = result_count;
    return result_ips;
}