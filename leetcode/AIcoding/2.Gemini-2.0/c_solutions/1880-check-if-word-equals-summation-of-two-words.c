#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int get_value(char *word) {
    int value = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        value = value * 10 + (word[i] - 'a');
    }
    return value;
}

bool isSumEqual(char * firstWord, char * secondWord, char * targetWord){
    int firstValue = get_value(firstWord);
    int secondValue = get_value(secondWord);
    int targetValue = get_value(targetWord);

    return (firstValue + secondValue == targetValue);
}