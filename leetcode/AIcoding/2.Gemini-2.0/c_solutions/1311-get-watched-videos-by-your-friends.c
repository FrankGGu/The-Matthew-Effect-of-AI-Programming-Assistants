#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_FRIENDS 501

typedef struct {
    char **videos;
    int videosSize;
} User;

char **watchedVideosByFriends(char ***watchedVideos, int watchedVideosSize, int *watchedVideosColSize, int **friends, int friendsSize, int *friendsColSize, int id, int level, int *returnSize) {
    int visited[MAX_FRIENDS] = {0};
    int queue[MAX_FRIENDS];
    int head = 0, tail = 0;
    visited[id] = 1;
    queue[tail++] = id;

    int distance[MAX_FRIENDS];
    for (int i = 0; i < MAX_FRIENDS; i++) {
        distance[i] = -1;
    }
    distance[id] = 0;

    while (head < tail) {
        int u = queue[head++];
        for (int i = 0; i < friendsColSize[u]; i++) {
            int v = friends[u][i];
            if (!visited[v]) {
                visited[v] = 1;
                queue[tail++] = v;
                distance[v] = distance[u] + 1;
            }
        }
    }

    char ***levelVideos = (char ***)malloc(sizeof(char **) * watchedVideosSize);
    int *levelVideosSizes = (int *)malloc(sizeof(int) * watchedVideosSize);
    for (int i = 0; i < watchedVideosSize; i++) {
        levelVideos[i] = NULL;
        levelVideosSizes[i] = 0;
    }

    for (int i = 0; i < watchedVideosSize; i++) {
        if (distance[i] == level) {
            levelVideos[i] = watchedVideos[i];
            levelVideosSizes[i] = watchedVideosColSize[i];
        }
    }

    char **allVideos = NULL;
    int allVideosSize = 0;
    for (int i = 0; i < watchedVideosSize; i++) {
        if (levelVideos[i] != NULL) {
            for (int j = 0; j < levelVideosSizes[i]; j++) {
                int found = 0;
                for (int k = 0; k < allVideosSize; k++) {
                    if (strcmp(allVideos[k], levelVideos[i][j]) == 0) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    allVideos = (char **)realloc(allVideos, sizeof(char *) * (allVideosSize + 1));
                    allVideos[allVideosSize++] = levelVideos[i][j];
                }
            }
        }
    }

    for (int i = 0; i < allVideosSize - 1; i++) {
        for (int j = i + 1; j < allVideosSize; j++) {
            int countI = 0, countJ = 0;
            for (int k = 0; k < watchedVideosSize; k++) {
                if (distance[k] == level) {
                    for (int l = 0; l < levelVideosSizes[k]; l++) {
                        if (strcmp(levelVideos[k][l], allVideos[i]) == 0) countI++;
                        if (strcmp(levelVideos[k][l], allVideos[j]) == 0) countJ++;
                    }
                }
            }
            if (countI > countJ) {
                char *temp = allVideos[i];
                allVideos[i] = allVideos[j];
                allVideos[j] = temp;
            } else if (countI == countJ && strcmp(allVideos[i], allVideos[j]) > 0) {
                char *temp = allVideos[i];
                allVideos[i] = allVideos[j];
                allVideos[j] = temp;
            }
        }
    }

    *returnSize = allVideosSize;
    return allVideos;
}