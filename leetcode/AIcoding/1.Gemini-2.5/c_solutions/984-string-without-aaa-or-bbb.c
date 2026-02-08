#include <stdlib.h>
#include <string.h>

char *strWithout3a3b(int a, int b) {
    char *res = (char *)malloc(a + b + 1);
    if (res == NULL) {
        return NULL;
    }
    int k = 0;
    int last_char_a_count = 0;
    int last_char_b_count = 0;

    while (a > 0 || b > 0) {
        if (a > 0 && b > 0) {
            if (last_char_a_count == 2) { // Must add 'b' to break 'aa'
                res[k++] = 'b';
                b--;
                last_char_b_count++;
                last_char_a_count = 0;
            } else if (last_char_b_count == 2) { // Must add 'a' to break 'bb'
                res[k++] = 'a';
                a--;
                last_char_a_count++;
                last_char_b_count = 0;
            } else { // Neither 'aaa' nor 'bbb' is imminent. Prioritize larger count.
                if (a >= b) {
                    res[k++] = 'a';
                    a--;
                    last_char_a_count++;
                    last_char_b_count = 0;
                } else { // b > a
                    res[k++] = 'b';
                    b--;
                    last_char_b_count++;
                    last_char_a_count = 0;
                }
            }
        } else if (a > 0) { // Only 'a's left
            res[k++] = 'a';
            a--;
            last_char_a_count++;
            last_char_b_count = 0; 
        } else if (b > 0) { // Only 'b's left
            res[k++] = 'b';
            b--;
            last_char_b_count++;
            last_char_a_count = 0; 
        }
    }

    res[k] = '\0';
    return res;
}