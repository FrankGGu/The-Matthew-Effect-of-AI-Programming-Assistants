#include <stdbool.h>
#include <string.h>

bool areSentencesSimilar(char **sentence1, int sentence1Size, char **sentence2, int sentence2Size) {
    if (sentence1Size > sentence2Size) {
        char **temp_s = sentence1;
        sentence1 = sentence2;
        sentence2 = temp_s;

        int temp_size = sentence1Size;
        sentence1Size = sentence2Size;
        sentence2Size = temp_size;
    }

    int i = 0;
    while (i < sentence1Size && strcmp(sentence1[i], sentence2[i]) == 0) {
        i++;
    }

    int j = 0;
    while (j < sentence1Size - i && strcmp(sentence1[sentence1Size - 1 - j], sentence2[sentence2Size - 1 - j]) == 0) {
        j++;
    }

    return (i + j >= sentence1Size);
}