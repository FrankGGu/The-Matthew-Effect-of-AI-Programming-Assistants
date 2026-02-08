#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDiff(int num) {
    char s[15];
    sprintf(s, "%d", num);
    int n = strlen(s);

    int max_num = num;
    int min_num = num;

    for (int i = 0; i < n; i++) {
        char digit_to_replace = s[i];

        char max_s[15];
        strcpy(max_s, s);
        for (int j = 0; j < n; j++) {
            if (max_s[j] == digit_to_replace) {
                max_s[j] = '9';
            }
        }
        max_num = atoi(max_s) > max_num ? atoi(max_s) : max_num;

        char min_s[15];
        strcpy(min_s, s);
        char replacement_digit = '0';
        if (min_s[0] == digit_to_replace) {
            replacement_digit = '1';
        }

        for (int j = 0; j < n; j++) {
            if (min_s[j] == digit_to_replace) {
                min_s[j] = replacement_digit;
            }
        }
        min_num = atoi(min_s) < min_num ? atoi(min_s) : min_num;
    }

    char max_s_initial[15];
    sprintf(max_s_initial, "%d", num);
    char digit_to_replace_max = max_s_initial[0];
    char max_s_final[15];
    strcpy(max_s_final, max_s_initial);
        for (int j = 0; j < n; j++) {
            if (max_s_final[j] == digit_to_replace_max) {
                max_s_final[j] = '9';
            }
        }
    max_num = atoi(max_s_final) > max_num ? atoi(max_s_final) : max_num;

    char min_s_initial[15];
    sprintf(min_s_initial, "%d", num);
    char digit_to_replace_min = min_s_initial[0];
    char min_s_final[15];
    strcpy(min_s_final, min_s_initial);
    char replacement_digit_min = '1';
        if(min_s_final[0] == '1')
        {
            for(int i = 0; i < n; i++)
            {
                if(min_s_final[i] != '0' && min_s_final[i] != '1')
                {
                    digit_to_replace_min = min_s_final[i];
                    replacement_digit_min = '0';
                    break;
                }
            }

        }

    for (int j = 0; j < n; j++) {
        if (min_s_final[j] == digit_to_replace_min) {
            min_s_final[j] = replacement_digit_min;
        }
    }
    min_num = atoi(min_s_final) < min_num ? atoi(min_s_final) : min_num;

    return max_num - min_num;
}