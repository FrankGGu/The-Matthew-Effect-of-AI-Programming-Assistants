#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNumberOfBalloons(char * text){
    int b = 0, a = 0, l = 0, o = 0, n = 0;
    for (int i = 0; text[i] != '\0'; i++) {
        if (text[i] == 'b') b++;
        else if (text[i] == 'a') a++;
        else if (text[i] == 'l') l++;
        else if (text[i] == 'o') o++;
        else if (text[i] == 'n') n++;
    }

    int min = b;
    if (a < min) min = a;
    if (l/2 < min) min = l/2;
    if (o/2 < min) min = o/2;
    if (n < min) min = n;

    return min;
}