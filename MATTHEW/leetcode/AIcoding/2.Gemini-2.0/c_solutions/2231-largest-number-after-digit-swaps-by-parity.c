#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestInteger(int num){
    char s[20];
    sprintf(s, "%d", num);
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if ((s[i] - '0') % 2 == (s[j] - '0') % 2) {
                if (s[j] > s[i]) {
                    char temp = s[i];
                    s[i] = s[j];
                    s[j] = temp;
                }
            }
        }
    }

    char *result = (char *)malloc((n + 1) * sizeof(char));
    strcpy(result, s);
    result[n] = '\0';
    return result;
}