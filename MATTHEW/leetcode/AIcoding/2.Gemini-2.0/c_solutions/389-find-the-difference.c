#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char findTheDifference(char * s, char * t){
    int s_sum = 0, t_sum = 0;
    while(*s){
        s_sum += *s;
        s++;
    }
    while(*t){
        t_sum += *t;
        t++;
    }
    return (char)(t_sum - s_sum);
}