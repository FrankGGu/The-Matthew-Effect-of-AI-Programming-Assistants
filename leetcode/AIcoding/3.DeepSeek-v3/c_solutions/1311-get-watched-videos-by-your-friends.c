typedef struct {
    char* video;
    int freq;
} VideoFreq;

typedef struct {
    int level;
    int idx;
} QueueNode;

int cmp(const void* a, const void* b) {
    VideoFreq* v1 = (VideoFreq*)a;
    VideoFreq* v2 = (VideoFreq*)b;
    if (v1->freq != v2->freq) {
        return v1->freq - v2->freq;
    }
    return strcmp(v1->video, v2->video);
}

char** watchedVideosByFriends(char*** watchedVideos, int watchedVideosSize, int* watchedVideosColSize, 
                             int** friends, int friendsSize, int* friendsColSize, 
                             int id, int level, int* returnSize) {
    int n = friendsSize;
    int* visited = (int*)calloc(n, sizeof(int));
    QueueNode* queue = (QueueNode*)malloc(n * sizeof(QueueNode));
    int front = 0, rear = 0;

    visited[id] = 1;
    queue[rear].idx = id;
    queue[rear].level = 0;
    rear++;

    int* levelFriends = (int*)malloc(n * sizeof(int));
    int levelCount = 0;

    while (front < rear) {
        QueueNode current = queue[front++];
        int curIdx = current.idx;
        int curLevel = current.level;

        if (curLevel == level) {
            levelFriends[levelCount++] = curIdx;
            continue;
        }

        for (int i = 0; i < friendsColSize[curIdx]; i++) {
            int friendIdx = friends[curIdx][i];
            if (!visited[friendIdx]) {
                visited[friendIdx] = 1;
                queue[rear].idx = friendIdx;
                queue[rear].level = curLevel + 1;
                rear++;
            }
        }
    }

    free(queue);
    free(visited);

    if (levelCount == 0) {
        *returnSize = 0;
        free(levelFriends);
        return NULL;
    }

    VideoFreq* videoFreqs = (VideoFreq*)malloc(10000 * sizeof(VideoFreq));
    int videoCount = 0;

    for (int i = 0; i < levelCount; i++) {
        int person = levelFriends[i];
        for (int j = 0; j < watchedVideosColSize[person]; j++) {
            char* video = watchedVideos[person][j];
            int found = 0;
            for (int k = 0; k < videoCount; k++) {
                if (strcmp(videoFreqs[k].video, video) == 0) {
                    videoFreqs[k].freq++;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                videoFreqs[videoCount].video = video;
                videoFreqs[videoCount].freq = 1;
                videoCount++;
            }
        }
    }

    free(levelFriends);

    qsort(videoFreqs, videoCount, sizeof(VideoFreq), cmp);

    char** result = (char**)malloc(videoCount * sizeof(char*));
    for (int i = 0; i < videoCount; i++) {
        result[i] = videoFreqs[i].video;
    }

    free(videoFreqs);
    *returnSize = videoCount;
    return result;
}