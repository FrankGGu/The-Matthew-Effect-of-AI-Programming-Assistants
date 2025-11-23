#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkDistances(char * s, int* distance, int distanceSize){
    int first[26];
    int last[26];
    for(int i = 0; i < 26; i++){
        first[i] = -1;
        last[i] = -1;
    }
    int len = 0;
    while(s[len] != '\0'){
        int index = s[len] - 'a';
        if(first[index] == -1){
            first[index] = len;
        }
        last[index] = len;
        len++;
    }
    for(int i = 0; i < 26; i++){
        if(first[i] != -1){
            int dist = last[i] - first[i] - 1;
            if(dist != distance[i]){
                return false;
            }
        }
    }
    return true;
}