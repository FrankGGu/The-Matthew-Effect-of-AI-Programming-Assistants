#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTimeToInitialState(char * word, int k){
    int n = strlen(word);
    int ans = 0;
    int i = k;
    while(i < n){
        bool match = true;
        for(int j = i; j < n; j++){
            if(word[j] != word[j - i]){
                match = false;
                break;
            }
        }
        ans++;
        if(match){
            break;
        }
        i += k;
    }
    return ans;
}