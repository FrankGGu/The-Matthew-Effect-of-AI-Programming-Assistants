#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int game(int* guess, int guessSize, int* answer, int answerSize){
    int count = 0;
    for(int i = 0; i < guessSize; i++){
        if(guess[i] == answer[i]){
            count++;
        }
    }
    return count;
}