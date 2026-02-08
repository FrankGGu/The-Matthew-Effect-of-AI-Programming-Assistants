#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLengthBetweenEqualCharacters(char * s){
    int first[26];
    int last[26];
    int len = strlen(s);
    int i;
    int ans = -1;

    for(i = 0; i < 26; i++){
        first[i] = -1;
        last[i] = -1;
    }

    for(i = 0; i < len; i++){
        int index = s[i] - 'a';
        if(first[index] == -1){
            first[index] = i;
        }
        last[index] = i;
    }

    for(i = 0; i < 26; i++){
        if(first[i] != -1 && last[i] != -1){
            ans = (ans > (last[i] - first[i] - 1)) ? ans : (last[i] - first[i] - 1);
        }
    }

    return ans;
}