#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * toGoatLatin(char * sentence){
    int len = strlen(sentence);
    char *result = (char*)malloc(sizeof(char) * (len * 3 + 1));
    result[0] = '\0';

    char *word = strtok(sentence, " ");
    int word_count = 1;

    while (word != NULL) {
        int word_len = strlen(word);
        char first_char = word[0];

        if (first_char == 'a' || first_char == 'e' || first_char == 'i' || first_char == 'o' || first_char == 'u' ||
            first_char == 'A' || first_char == 'E' || first_char == 'I' || first_char == 'O' || first_char == 'U') {
            strcat(result, word);
        } else {
            char temp[word_len + 1];
            strcpy(temp, word + 1);
            temp[word_len - 1] = first_char;
            temp[word_len] = '\0';
            strcat(result, temp);
        }

        strcat(result, "ma");

        for (int i = 0; i < word_count; i++) {
            strcat(result, "a");
        }

        strcat(result, " ");
        word = strtok(NULL, " ");
        word_count++;
    }

    result[strlen(result) - 1] = '\0';
    return result;
}