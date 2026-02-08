#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* key;
    int count;
} Pair;

typedef struct {
    Pair* pairs;
    int size;
} Result;

int compare(const void* a, const void* b) {
    Pair* pairA = (Pair*)a;
    Pair* pairB = (Pair*)b;
    return strcmp(pairA->key, pairB->key);
}

char** findCategoryRecommendationPairs(char** userSongs, int userSongsSize, char*** songToSongs, int songToSongsSize, int* songToSongsColSize, int** similarSongs, int similarSongsSize, int* similarSongsColSize, int* returnSize) {
    int* visited = (int*)calloc(userSongsSize, sizeof(int));
    Result result = {NULL, 0};

    for (int i = 0; i < userSongsSize; i++) {
        if (visited[i]) continue;
        char* userSong = userSongs[i];
        int userSongLen = strlen(userSong);
        int found = 0;

        for (int j = 0; j < similarSongsSize; j++) {
            if (similarSongs[j][0] == userSong[0] && strcmp(similarSongs[j], userSong) == 0) {
                for (int k = 1; k < similarSongsColSize[j]; k++) {
                    char* similarSong = similarSongs[j][k];
                    int similarSongLen = strlen(similarSong);

                    for (int m = 0; m < songToSongsSize; m++) {
                        for (int n = 0; n < songToSongsColSize[m]; n++) {
                            if (strcmp(songToSongs[m][n], similarSong) == 0) {
                                for (int p = 0; p < userSongsSize; p++) {
                                    if (p != i && strcmp(userSongs[p], songToSongs[m][n]) == 0) {
                                        found = 1;
                                        break;
                                    }
                                }
                                if (found) {
                                    Pair* newPair = (Pair*)malloc(sizeof(Pair));
                                    newPair->key = (char*)malloc(userSongLen + similarSongLen + 2);
                                    sprintf(newPair->key, "%s,%s", userSong, similarSong);
                                    newPair->count = 1;
                                    result.pairs = (Pair*)realloc(result.pairs, (result.size + 1) * sizeof(Pair));
                                    result.pairs[result.size++] = *newPair;
                                    free(newPair->key);
                                    free(newPair);
                                    break;
                                }
                            }
                        }
                        if (found) break;
                    }
                    if (found) break;
                }
                if (found) break;
            }
        }

        if (found) {
            visited[i] = 1;
        }
    }

    qsort(result.pairs, result.size, sizeof(Pair), compare);

    char** output = (char**)malloc(result.size * sizeof(char*));
    for (int i = 0; i < result.size; i++) {
        output[i] = (char*)malloc(strlen(result.pairs[i].key) + 1);
        strcpy(output[i], result.pairs[i].key);
    }

    *returnSize = result.size;
    free(visited);
    free(result.pairs);
    return output;
}