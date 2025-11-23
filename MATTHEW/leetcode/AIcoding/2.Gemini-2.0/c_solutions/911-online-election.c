#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* persons;
    int* times;
    int len;
} TopVotedCandidate;

TopVotedCandidate* topVotedCandidateCreate(int* persons, int personsSize, int* times, int timesSize) {
    TopVotedCandidate* obj = (TopVotedCandidate*)malloc(sizeof(TopVotedCandidate));
    obj->persons = (int*)malloc(sizeof(int) * personsSize);
    obj->times = (int*)malloc(sizeof(int) * timesSize);
    obj->len = timesSize;

    int* votes = (int*)calloc(personsSize, sizeof(int));
    int leader = persons[0];
    votes[persons[0]]++;
    obj->persons[0] = leader;
    obj->times[0] = times[0];

    for (int i = 1; i < personsSize; i++) {
        votes[persons[i]]++;
        if (votes[persons[i]] >= votes[leader]) {
            if (votes[persons[i]] > votes[leader]) {
                leader = persons[i];
            } else if (persons[i] > leader) {
                leader = persons[i];
            }
        }
        obj->persons[i] = leader;
        obj->times[i] = times[i];
    }

    free(votes);
    return obj;
}

int topVotedCandidateQ(TopVotedCandidate* obj, int t) {
    int left = 0;
    int right = obj->len - 1;
    int ans = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (obj->times[mid] <= t) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return obj->persons[ans];
}

void topVotedCandidateFree(TopVotedCandidate* obj) {
    free(obj->persons);
    free(obj->times);
    free(obj);
}