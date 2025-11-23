#include <string.h>
#include <stdlib.h>

int secondsToRemoveOccurrences(char * s) {
    int n = strlen(s);
    char *temp_s = (char *)malloc((n + 1) * sizeof(char));

    int time = 0;
    int made_change;

    while (1) {
        made_change = 0;
        strcpy(temp_s, s); 

        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == '0' && s[i+1] == '1') {
                temp_s[i] = '1';
                temp_s[i+1] = '0';
                made_change = 1;
            }
        }

        if (!made_change) {
            break; 
        }

        strcpy(s, temp_s); 
        time++;
    }

    free(temp_s);
    return time;
}