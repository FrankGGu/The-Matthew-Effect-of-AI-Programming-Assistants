#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPeopleToTeach(char** people, int peopleSize, char* languages, int languagesSize, char* topics, int topicsSize) {
    int* langMap = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < languagesSize; i++) {
        langMap[languages[i] - 'a'] = 1;
    }

    int* topicLangs = (int*)calloc(topicsSize, sizeof(int));
    for (int i = 0; i < topicsSize; i++) {
        topicLangs[i] = 0;
        for (int j = 0; j < languagesSize; j++) {
            if (topics[i] == languages[j]) {
                topicLangs[i] = 1;
                break;
            }
        }
    }

    int* personLangs = (int*)calloc(peopleSize, sizeof(int));
    for (int i = 0; i < peopleSize; i++) {
        personLangs[i] = 0;
        for (int j = 0; j < languagesSize; j++) {
            for (int k = 0; k < strlen(people[i]); k++) {
                if (people[i][k] == languages[j]) {
                    personLangs[i] = 1;
                    break;
                }
            }
        }
    }

    int count = 0;
    for (int i = 0; i < peopleSize; i++) {
        if (personLangs[i] == 0) {
            count++;
        }
    }

    free(langMap);
    free(topicLangs);
    free(personLangs);

    return count;
}