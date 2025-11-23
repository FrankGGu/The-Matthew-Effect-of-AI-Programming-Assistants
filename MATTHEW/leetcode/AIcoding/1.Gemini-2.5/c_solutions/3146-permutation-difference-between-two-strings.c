#include <string.h>
#include <stdlib.h>

int findPermutationDifference(char * s, char * t, char * p){
    int s_indices[26];
    int t_indices[26];
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        s_indices[s[i] - 'a'] = i;
    }

    for (int i = 0; i < len; i++) {
        t_indices[t[i] - 'a'] = i;
    }

    int total_difference = 0;
    for (int i = 0; i < len; i++) {
        char current_char = p[i];
        int s_idx = s_indices[current_char - 'a'];
        int t_idx = t_indices[current_char - 'a'];
        total_difference += abs(s_idx - t_idx);
    }

    return total_difference;
}