#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char* videoName;
    int freq;
} VideoFreq;

int compareVideoFreq(const void* a, const void* b) {
    VideoFreq* va = (VideoFreq*)a;
    VideoFreq* vb = (VideoFreq*)b;

    if (va->freq != vb->freq) {
        return vb->freq - va->freq; // Descending frequency
    }
    return strcmp(va->videoName, vb->videoName); // Ascending alphabetically
}

void addOrUpdateVideo(const char* video, VideoFreq** videoFreqsPtr, int* countPtr, int* capacityPtr) {
    // Search for existing video
    for (int i = 0; i < *countPtr; i++) {
        if (strcmp((*videoFreqsPtr)[i].videoName, video) == 0) {
            (*videoFreqsPtr)[i].freq++;
            return;
        }
    }

    // Video not found, add new entry
    if (*countPtr == *capacityPtr) {
        *capacityPtr = (*capacityPtr == 0) ? 4 : (*capacityPtr * 2);
        *videoFreqsPtr = (VideoFreq*)realloc(*videoFreqsPtr, *capacityPtr * sizeof(VideoFreq));
    }
    (*videoFreqsPtr)[*countPtr].videoName = strdup(video); // Make a deep copy of the string
    (*videoFreqsPtr)[*countPtr].freq = 1;
    (*countPtr)++;
}

char** watchedVideosByFriends(char*** watchedVideos, int watchedVideosSize, int* watchedVideosColSize, int** friends, int friendsSize, int* friendsColSize, int id, int level, int* returnSize) {
    int n = watchedVideosSize;

    // 1. Build Adjacency List
    // First pass to count degrees for each person to allocate memory efficiently
    int* adjDegrees = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        adjDegrees[i] = friendsColSize[i];
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(adjDegrees[i] * sizeof(int));
        memcpy(adj[i], friends[i], adjDegrees[i] * sizeof(int)); // Copy friends directly
    }
    free(adjDegrees);

    // 2. BFS to find friends at the specified 'level'
    int* queue = (int*)malloc(n * sizeof(int));
    int head = 0, tail = 0;
    bool* visited = (bool*)calloc(n, sizeof(bool));
    int* levels = (int*)malloc(n * sizeof(int));

    queue[tail++] = id;
    visited[id] = true;
    levels[id] = 0;

    int* levelKFriends = NULL;
    int levelKFriendsCount = 0;
    int levelKFriendsCapacity = 0;

    while (head < tail) {
        int curr = queue[head++];

        // If 'curr' is at the target 'level' and 'level' is greater than 0
        // (as "friends" implies not self, so level 0 should not yield friends)
        if (levels[curr] == level) {
            if (level > 0) { 
                if (levelKFriendsCount == levelKFriendsCapacity) {
                    levelKFriendsCapacity = (levelKFriendsCapacity == 0) ? 4 : (levelKFriendsCapacity * 2);
                    levelKFriends = (int*)realloc(levelKFriends, levelKFriendsCapacity * sizeof(int));
                }
                levelKFriends[levelKFriendsCount++] = curr;
            }
        }

        // Optimization: if we've gone past the target level, no need to explore further
        if (levels[curr] > level) {
            break;
        }

        // Explore neighbors
        for (int i = 0; i < friendsColSize[curr]; i++) {
            int neighbor = adj[curr][i];
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                levels[neighbor] = levels[curr] + 1;
                queue[tail++] = neighbor;
            }
        }
    }

    // Free BFS related memory
    free(queue);
    free(visited);
    free(levels);

    // Free adjacency list
    for(int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);

    // 3. Collect Watched Videos & 4. Count Frequencies
    VideoFreq* videoFreqs = NULL;
    int videoFreqCount = 0;
    int videoFreqCapacity = 0;

    for (int i = 0; i < levelKFriendsCount; i++) {
        int friendId = levelKFriends[i];
        for (int j = 0; j < watchedVideosColSize[friendId]; j++) {
            addOrUpdateVideo(watchedVideos[friendId][j], &videoFreqs, &videoFreqCount, &videoFreqCapacity);
        }
    }
    free(levelKFriends); // Free the list of level-k friends

    // 5. Sort Videos by frequency (desc) then name (asc)
    qsort(videoFreqs, videoFreqCount, sizeof(VideoFreq), compareVideoFreq);

    // 6. Prepare Result
    char** result = (char**)malloc(videoFreqCount * sizeof(char*));
    for (int i = 0; i < videoFreqCount; i++) {
        result[i] = videoFreqs[i].videoName; // Transfer ownership of the strdup'd string
    }
    *returnSize = videoFreqCount;

    // Free the array of VideoFreq structs itself, but not the videoName strings
    // as their ownership has been transferred to 'result'.
    free(videoFreqs);

    return result;
}