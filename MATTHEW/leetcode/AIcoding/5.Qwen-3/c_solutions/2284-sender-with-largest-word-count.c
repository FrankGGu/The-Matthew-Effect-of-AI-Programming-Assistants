#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int count;
} Sender;

int compare(const void* a, const void* b) {
    Sender* x = (Sender*)a;
    Sender* y = (Sender*)b;
    return y->count - x->count;
}

char* largestWordCount(char** messages, int messagesSize) {
    Sender* senders = (Sender*)malloc(messagesSize * sizeof(Sender));
    int senderCount = 0;

    for (int i = 0; i < messagesSize; i++) {
        char* message = messages[i];
        int wordCount = 0;
        int inWord = 0;
        for (int j = 0; message[j] != '\0'; j++) {
            if (message[j] == ' ') {
                inWord = 0;
            } else if (!inWord) {
                inWord = 1;
                wordCount++;
            }
        }

        int found = 0;
        for (int k = 0; k < senderCount; k++) {
            if (strcmp(senders[k].name, messages[i]) == 0) {
                senders[k].count += wordCount;
                found = 1;
                break;
            }
        }

        if (!found) {
            senders[senderCount].name = strdup(messages[i]);
            senders[senderCount].count = wordCount;
            senderCount++;
        }
    }

    qsort(senders, senderCount, sizeof(Sender), compare);

    char* result = strdup(senders[0].name);
    for (int i = 0; i < senderCount; i++) {
        free(senders[i].name);
    }
    free(senders);

    return result;
}