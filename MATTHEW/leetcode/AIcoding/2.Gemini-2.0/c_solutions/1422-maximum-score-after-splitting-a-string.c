#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScore(char * s){
    int len = 0;
    while(s[len] != '\0'){
        len++;
    }
    int max_score = 0;
    for(int i = 1; i < len; i++){
        int score = 0;
        for(int j = 0; j < i; j++){
            if(s[j] == '0'){
                score++;
            }
        }
        for(int j = i; j < len; j++){
            if(s[j] == '1'){
                score++;
            }
        }
        if(score > max_score){
            max_score = score;
        }
    }
    return max_score;
}