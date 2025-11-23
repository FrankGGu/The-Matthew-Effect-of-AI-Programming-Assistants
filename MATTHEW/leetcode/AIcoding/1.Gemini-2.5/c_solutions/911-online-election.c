#include <stdlib.h>

typedef struct {
    int* persons;
    int* times;
    int n;
    int* winners_at_time_idx;
} TopVotedCandidate;

TopVotedCandidate* topVotedCandidateCreate(int* persons, int personsSize, int* times, int timesSize) {
    TopVotedCandidate* obj = (TopVotedCandidate*)malloc(sizeof(TopVotedCandidate));
    obj->persons = persons;
    obj->times = times;
    obj->n = personsSize;

    obj->winners_at_time_idx = (int*)malloc(personsSize * sizeof(int));

    int counts[100] = {0}; // Person IDs are 0-99

    int current_leader_id = -1;
    int max_votes = -1;

    for (int i = 0; i < personsSize; ++i) {
        int p = persons[i];
        counts[p]++;

        if (counts[p] >= max_votes) {
            max_votes = counts[p];
            current_leader_id = p;
        }
        obj->winners_at_time_idx[i] = current_leader_id;
    }

    return obj;
}

int topVotedCandidateQ(TopVotedCandidate* obj, int t) {
    int low = 0;
    int high = obj->n - 1;
    int ans_idx = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (obj->times[mid] <= t) {
            ans_idx = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return obj->winners_at_time_idx[ans_idx];
}

void topVotedCandidateFree(TopVotedCandidate* obj) {
    free(obj->winners_at_time_idx);
    free(obj);
}