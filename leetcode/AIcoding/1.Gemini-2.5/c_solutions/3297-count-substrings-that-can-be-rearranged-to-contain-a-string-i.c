#include <string.h>

int countSubstrings(char * s){
    int n = strlen(s);
    int count = 0;
    int last_a = -1;
    int last_b = -1;
    int last_c = -1;

    for (int j = 0; j < n; j++) {
        if (s[j] == 'a') {
            last_a = j;
        } else if (s[j] == 'b') {
            last_b = j;
        } else if (s[j] == 'c') {
            last_c = j;
        }

        if (last_a != -1 && last_b != -1 && last_c != -1) {
            int min_last_char_idx = last_a;
            if (last_b < min_last_char_idx) {
                min_last_char_idx = last_b;
            }
            if (last_c < min_last_char_idx) {
                min_last_char_idx = last_c;
            }

            count += (min_last_char_idx + 1);
        }
    }
    return count;
}