#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* originalDigits(char* s) {
    int count[10] = {0};
    int freq[26] = {0};
    int i;

    for (i = 0; s[i]; i++)
        freq[s[i] - 'a']++;

    count[0] = freq['z' - 'a'];
    count[2] = freq['w' - 'a'];
    count[4] = freq['u' - 'a'];
    count[6] = freq['x' - 'a'];
    count[8] = freq['g' - 'a'];
    count[1] = freq['o' - 'a'] - count[0] - count[2] - count[4];
    count[3] = freq['h' - 'a'] - count[8];
    count[5] = freq['f' - 'a'] - count[4];
    count[7] = freq['s' - 'a'] - count[6];
    count[9] = freq['i' - 'a'] - count[5] - count[6] - count[8];

    int len = 0;
    for (i = 0; i < 10; i++)
        len += count[i];

    char* result = (char*)malloc((len + 1) * sizeof(char));
    result[0] = '\0';

    for (i = 0; i < 10; i++) {
        for (int j = 0; j < count[i]; j++) {
            strcat(result, &('0' + i));
        }
    }

    return result;
}