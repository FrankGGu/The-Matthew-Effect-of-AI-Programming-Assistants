#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTimeToInitialState(char * word, int k){
    int n = strlen(word);
    for(int i = k; i < n; i += k){
        int j = 0;
        while(j < n - i && word[j] == word[i + j]){
            j++;
        }
        if(j == n - i){
            return i / k;
        }
    }
    return (n + k - 1) / k;
}