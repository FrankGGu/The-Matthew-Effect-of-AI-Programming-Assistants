#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_DECODED_LEN 100001 
#define MAX_STACK_DEPTH 20   

char* decodeString(char* s) {
    char* decoded_string = (char*)malloc(sizeof(char) * MAX_DECODED_LEN);
    int decoded_idx = 0;

    int num_stack[MAX_STACK_DEPTH];
    int num_top = -1;

    int str_len_stack[MAX_STACK_DEPTH]; 
    int str_len_top = -1;

    int current_num = 0;
    int i = 0;

    while (s[i] != '\0') {
        if (isdigit(s[i])) {
            current_num = current_num * 10 + (s[i] - '0');
        } else if (s[i] == '[') {
            num_stack[++num_top] = current_num;
            str_len_stack[++str_len_top] = decoded_idx;
            current_num = 0; 
        } else if (s[i] == ']') {
            int count = num_stack[num_top--];
            int prev_decoded_len = str_len_stack[str_len_top--];
            int segment_len = decoded_idx - prev_decoded_len;

            for (int k = 0; k < count - 1; k++) {
                memcpy(decoded_string + decoded_idx, decoded_string + prev_decoded_len, segment_len);
                decoded_idx += segment_len;
            }
        } else { 
            decoded_string[decoded_idx++] = s[i];
        }
        i++;
    }

    decoded_string[decoded_idx] = '\0'; 
    return decoded_string;
}