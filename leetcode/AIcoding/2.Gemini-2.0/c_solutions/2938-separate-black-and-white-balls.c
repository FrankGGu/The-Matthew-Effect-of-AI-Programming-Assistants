#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumSteps(char * s){
    int n = 0;
    while(s[n] != '\0'){
        n++;
    }
    int steps = 0;
    int white_count = 0;
    for(int i = 0; i < n; i++){
        if(s[i] == '0'){
            steps += white_count;
        } else {
            white_count++;
        }
    }
    return steps;
}