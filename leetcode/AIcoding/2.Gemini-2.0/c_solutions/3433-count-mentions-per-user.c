#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char user[21];
    int count;
} UserMention;

int compareUserMention(const void *a, const void *b) {
    return strcmp(((UserMention *)a)->user, ((UserMention *)b)->user);
}

char ** countMentions(char ** tweets, int tweetsSize, int* returnSize){
    int capacity = 10;
    UserMention *mentions = (UserMention *)malloc(capacity * sizeof(UserMention));
    int count = 0;

    for (int i = 0; i < tweetsSize; i++) {
        char *tweet = tweets[i];
        char *start = tweet;
        while ((start = strchr(start, '@')) != NULL) {
            start++;
            char user[21] = "";
            int j = 0;
            while (start[j] != ' ' && start[j] != '\0') {
                user[j] = start[j];
                j++;
            }
            user[j] = '\0';

            int found = 0;
            for (int k = 0; k < count; k++) {
                if (strcmp(mentions[k].user, user) == 0) {
                    mentions[k].count++;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                if (count == capacity) {
                    capacity *= 2;
                    mentions = (UserMention *)realloc(mentions, capacity * sizeof(UserMention));
                }
                strcpy(mentions[count].user, user);
                mentions[count].count = 1;
                count++;
            }
            start += j;
        }
    }

    qsort(mentions, count, sizeof(UserMention), compareUserMention);

    char **result = (char **)malloc(count * sizeof(char *));
    for (int i = 0; i < count; i++) {
        char buffer[100];
        sprintf(buffer, "%s:%d", mentions[i].user, mentions[i].count);
        result[i] = (char *)malloc((strlen(buffer) + 1) * sizeof(char));
        strcpy(result[i], buffer);
    }

    *returnSize = count;
    free(mentions);
    return result;
}