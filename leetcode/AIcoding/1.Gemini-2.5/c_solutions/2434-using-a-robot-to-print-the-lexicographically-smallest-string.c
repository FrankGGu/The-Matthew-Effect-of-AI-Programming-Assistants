#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char *robotWithString(char *s) {
    int n = strlen(s);

    if (n == 0) {
        char *ans = (char *)malloc(sizeof(char));
        ans[0] = '\0';
        return ans;
    }

    char *min_s_suffix = (char *)malloc(sizeof(char) * n);
    min_s_suffix[n - 1] = s[n - 1];
    for (int i = n - 2; i >= 0; i--) {
        if (s[i] < min_s_suffix[i + 1]) {
            min_s_suffix[i] = s[i];
        } else {
            min_s_suffix[i] = min_s_suffix[i + 1];
        }
    }

    char *t_stack = (char *)malloc(sizeof(char) * n);
    int t_top = -1;

    char *ans = (char *)malloc(sizeof(char) * (n + 1));
    int ans_idx = 0;

    for (int i = 0; i < n; i++) {
        t_top++;
        t_stack[t_top] = s[i];

        while (t_top != -1) {
            if (i + 1 < n) {
                if (t_stack[t_top] <= min_s_suffix[i + 1]) {
                    ans[ans_idx++] = t_stack[t_top];
                    t_top--;
                } else {
                    break;
                }
            } else {
                ans[ans_idx++] = t_stack[t_top];
                t_top--;
            }
        }
    }

    while (t_top != -1) {
        ans[ans_idx++] = t_stack[t_top];
        t_top--;
    }

    ans[ans_idx] = '\0';

    free(min_s_suffix);
    free(t_stack);

    return ans;
}