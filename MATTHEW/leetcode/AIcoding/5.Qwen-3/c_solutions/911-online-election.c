#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int timestamp;
    char* name;
} Vote;

typedef struct {
    int time;
    char* winner;
} Result;

typedef struct {
    char* name;
    int count;
    int lastVoteTime;
} Candidate;

typedef struct {
    Candidate** candidates;
    int candidateCount;
    int* times;
    int timeCount;
    int* voteCounts;
    int* winnerAtTime;
} TopVotedCandidate;

TopVotedCandidate* topVotedCandidateCreate(char** names, int namesSize, int* times, int timesSize) {
    TopVotedCandidate* obj = (TopVotedCandidate*)malloc(sizeof(TopVotedCandidate));
    obj->candidateCount = namesSize;
    obj->candidates = (Candidate**)malloc(namesSize * sizeof(Candidate*));
    for (int i = 0; i < namesSize; i++) {
        obj->candidates[i] = (Candidate*)malloc(sizeof(Candidate));
        obj->candidates[i]->name = strdup(names[i]);
        obj->candidates[i]->count = 0;
        obj->candidates[i]->lastVoteTime = -1;
    }
    obj->timeCount = timesSize;
    obj->times = (int*)malloc(timesSize * sizeof(int));
    memcpy(obj->times, times, timesSize * sizeof(int));
    obj->voteCounts = (int*)malloc(timesSize * sizeof(int));
    obj->winnerAtTime = (int*)malloc(timesSize * sizeof(int));
    int maxVotes = 0;
    char* currentWinner = NULL;
    for (int i = 0; i < timesSize; i++) {
        int time = times[i];
        for (int j = 0; j < namesSize; j++) {
            if (strcmp(obj->candidates[j]->name, names[i]) == 0) {
                obj->candidates[j]->count++;
                obj->candidates[j]->lastVoteTime = time;
                break;
            }
        }
        for (int j = 0; j < namesSize; j++) {
            if (obj->candidates[j]->count > maxVotes) {
                maxVotes = obj->candidates[j]->count;
                currentWinner = obj->candidates[j]->name;
            }
        }
        obj->voteCounts[i] = maxVotes;
        obj->winnerAtTime[i] = (int)currentWinner;
    }
    return obj;
}

char* topVotedCandidateQ(TopVotedCandidate* obj, int t) {
    int left = 0;
    int right = obj->timeCount - 1;
    int res = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (obj->times[mid] <= t) {
            res = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return obj->candidates[obj->winnerAtTime[res]]->name;
}

void topVotedCandidateFree(TopVotedCandidate* obj) {
    for (int i = 0; i < obj->candidateCount; i++) {
        free(obj->candidates[i]->name);
        free(obj->candidates[i]);
    }
    free(obj->candidates);
    free(obj->times);
    free(obj->voteCounts);
    free(obj->winnerAtTime);
    free(obj);
}