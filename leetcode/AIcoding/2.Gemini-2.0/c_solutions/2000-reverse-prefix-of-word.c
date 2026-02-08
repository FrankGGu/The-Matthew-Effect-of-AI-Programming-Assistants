#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * reversePrefix(char * word, char ch){
    int index = -1;
    for(int i = 0; word[i] != '\0'; i++){
        if(word[i] == ch){
            index = i;
            break;
        }
    }
    if(index == -1) return word;

    int left = 0;
    int right = index;
    while(left < right){
        char temp = word[left];
        word[left] = word[right];
        word[right] = temp;
        left++;
        right--;
    }
    return word;
}