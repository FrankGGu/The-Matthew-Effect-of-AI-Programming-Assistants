#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int sender_id;
    int receiver_id;
    char* content;
} Message;

char** reportSpam(Message* messages, int messagesSize, int* returnSize) {
    int* send_counts = (int*)calloc(100001, sizeof(int));
    char** result = (char**)malloc(messagesSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < messagesSize; i++) {
        send_counts[messages[i].sender_id]++;
    }

    for (int i = 1; i <= 100000; i++) {
        if (send_counts[i] >= 2) {
            char* str = (char*)malloc(10 * sizeof(char));
            sprintf(str, "%d", i);
            result[*returnSize] = str;
            (*returnSize)++;
        }
    }

    free(send_counts);
    return result;
}