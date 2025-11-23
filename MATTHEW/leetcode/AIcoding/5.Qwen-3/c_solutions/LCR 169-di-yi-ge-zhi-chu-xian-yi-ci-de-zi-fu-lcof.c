#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *word;
    int count;
} WordCount;

int compare(const void *a, const void *b) {
    WordCount *w1 = (WordCount *)a;
    WordCount *w2 = (WordCount *)b;
    return strcmp(w1->word, w2->word);
}

char** splitWordsBySeparator(char** words, int wordsSize, char separator, int* returnSize) {
    int totalWords = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        int count = 0;
        for (int j = 0; j < len; j++) {
            if (words[i][j] == separator) {
                count++;
            }
        }
        totalWords += count + 1;
    }

    char **result = (char **)malloc(totalWords * sizeof(char *));
    int index = 0;

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        char *start = word;
        for (int j = 0; j < strlen(word); j++) {
            if (word[j] == separator) {
                int len = j - (int)(start - word);
                result[index] = (char *)malloc((len + 1) * sizeof(char));
                strncpy(result[index], start, len);
                result[index][len] = '\0';
                index++;
                start = word + j + 1;
            }
        }
        int len = strlen(word) - (int)(start - word);
        result[index] = (char *)malloc((len + 1) * sizeof(char));
        strncpy(result[index], start, len);
        result[index][len] = '\0';
        index++;
    }

    *returnSize = index;
    return result;
}

char** findPrefixes(char** words, int wordsSize, int* returnSize) {
    int totalWords = 0;
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        totalWords += len;
    }

    WordCount *counts = (WordCount *)malloc(totalWords * sizeof(WordCount));
    int countIndex = 0;

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        for (int j = 1; j <= strlen(word); j++) {
            char *prefix = (char *)malloc(j + 1);
            strncpy(prefix, word, j);
            prefix[j] = '\0';
            counts[countIndex].word = prefix;
            counts[countIndex].count = 1;
            countIndex++;
        }
    }

    qsort(counts, countIndex, sizeof(WordCount), compare);

    char **result = (char **)malloc(countIndex * sizeof(char *));
    int resultIndex = 0;
    int i = 0;

    while (i < countIndex) {
        char *current = counts[i].word;
        int j = i + 1;
        while (j < countIndex && strcmp(counts[j].word, current) == 0) {
            counts[i].count += counts[j].count;
            j++;
        }
        if (counts[i].count > 1) {
            result[resultIndex++] = current;
        }
        i = j;
    }

    *returnSize = resultIndex;
    free(counts);
    return result;
}

char** getModifiedList(char** words, int wordsSize, char separator, int* returnSize) {
    int splitSize;
    char **splitWords = splitWordsBySeparator(words, wordsSize, separator, &splitSize);
    int prefixesSize;
    char **prefixes = findPrefixes(splitWords, splitSize, &prefixesSize);

    char **result = (char **)malloc(prefixesSize * sizeof(char *));
    for (int i = 0; i < prefixesSize; i++) {
        result[i] = prefixes[i];
    }

    *returnSize = prefixesSize;
    free(prefixes);
    for (int i = 0; i < splitSize; i++) {
        free(splitWords[i]);
    }
    free(splitWords);
    return result;
}