#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VIDEOS 1000
#define MAX_FRIENDS 100

typedef struct {
    char video[MAX_VIDEOS][30];
    int count;
} VideoList;

typedef struct {
    VideoList videoList;
    int* friends;
    int friendsCount;
} User;

int cmp(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

char **watchedVideosByFriends(char ***watchedVideos, int watchedVideosSize, int *watchedVideosColSize, int *friends, int friendsSize, int *returnSize) {
    int videoCount[MAX_VIDEOS] = {0};
    char **result = (char **)malloc(MAX_VIDEOS * sizeof(char *));
    int idx = 0;

    for (int i = 0; i < friendsSize; i++) {
        int friendId = friends[i];
        for (int j = 0; j < watchedVideosColSize[friendId]; j++) {
            videoCount[watchedVideos[friendId][j][0]]++;
        }
    }

    for (int i = 0; i < MAX_VIDEOS; i++) {
        if (videoCount[i] > 0) {
            result[idx] = (char *)malloc(30 * sizeof(char));
            strcpy(result[idx], watchedVideos[i]);
            idx++;
        }
    }

    qsort(result, idx, sizeof(char *), cmp);
    *returnSize = idx;
    return result;
}