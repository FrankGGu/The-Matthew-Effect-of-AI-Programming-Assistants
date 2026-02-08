#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int uniqueMorseRepresentations(char ** words, int wordsSize){
    char *morse[] = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};
    char transformations[wordsSize][100];
    int count = 0;

    for(int i = 0; i < wordsSize; i++){
        char *word = words[i];
        char transformation[100] = "";
        for(int j = 0; j < strlen(word); j++){
            char c = word[j];
            strcat(transformation, morse[c - 'a']);
        }

        bool found = false;
        for(int k = 0; k < count; k++){
            if(strcmp(transformations[k], transformation) == 0){
                found = true;
                break;
            }
        }

        if(!found){
            strcpy(transformations[count], transformation);
            count++;
        }
    }

    return count;
}