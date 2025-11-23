#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

typedef struct {
    int start;
    int length;
} Block;

int maxRepOpt1(char * text) {
    int n = strlen(text);
    if (n == 0) {
        return 0;
    }

    int counts[26] = {0};
    for (int i = 0; i < n; i++) {
        counts[text[i] - 'a']++;
    }

    int overall_max = 0;

    for (int char_code = 0; char_code < 26; char_code++) {
        char ch = 'a' + char_code;
        int total_ch_count = counts[char_code];

        if (total_ch_count == 0) {
            continue;
        }

        Block blocks[n / 2 + 1]; 
        int block_count = 0;

        for (int i = 0; i < n; ) {
            if (text[i] == ch) {
                int j = i;
                while (j < n && text[j] == ch) {
                    j++;
                }
                blocks[block_count].start = i;
                blocks[block_count].length = j - i;
                block_count++;
                i = j;
            } else {
                i++;
            }
        }

        int max_len_for_ch = 0;

        for (int k = 0; k < block_count; k++) {
            int current_len = blocks[k].length;
            max_len_for_ch = max(max_len_for_ch, current_len);
            if (current_len < total_ch_count) {
                max_len_for_ch = max(max_len_for_ch, current_len + 1);
            }
        }

        for (int k = 0; k < block_count - 1; k++) {
            int L1 = blocks[k].length;
            int L2 = blocks[k+1].length;
            int end_L1_idx = blocks[k].start + L1 - 1;
            int start_L2_idx = blocks[k+1].start;

            if (start_L2_idx - end_L1_idx == 2) { 
                if (L1 + L2 < total_ch_count) {
                    max_len_for_ch = max(max_len_for_ch, L1 + L2 + 1);
                } else { 
                    max_len_for_ch = max(max_len_for_ch, L1 + L2);
                }
            }
        }
        overall_max = max(overall_max, max_len_for_ch);
    }

    return overall_max;
}