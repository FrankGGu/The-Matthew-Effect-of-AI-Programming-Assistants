#include <string.h>
#include <stdbool.h>

int wordToValue(char *word) {
    int value = 0;
    for (int i = 0; word[i] != '\0'; i++) {
        value = value * 10 + (word[i] - 'a');
    }
    return value;
}

bool isSumEqual(char * firstWord, char * secondWord, char * targetWord){
    int value1 = wordToValue(firstWord);
    int value2 = wordToValue(secondWord);
    int value3 = wordToValue(targetWord);

    return (value1 + value2 == value3);
}