typedef struct {
    int *times;
    int *leaders;
    int size;
} TopVotedCandidate;

TopVotedCandidate* topVotedCandidateCreate(int* persons, int personsSize, int* times, int timesSize) {
    TopVotedCandidate* obj = (TopVotedCandidate*)malloc(sizeof(TopVotedCandidate));
    obj->times = (int*)malloc(timesSize * sizeof(int));
    obj->leaders = (int*)malloc(timesSize * sizeof(int));
    obj->size = timesSize;

    for (int i = 0; i < timesSize; i++) {
        obj->times[i] = times[i];
    }

    int* votes = (int*)calloc(personsSize, sizeof(int));
    int current_leader = -1;
    int max_votes = 0;

    for (int i = 0; i < timesSize; i++) {
        int person = persons[i];
        votes[person]++;
        if (votes[person] >= max_votes) {
            max_votes = votes[person];
            current_leader = person;
        }
        obj->leaders[i] = current_leader;
    }

    free(votes);
    return obj;
}

int topVotedCandidateQ(TopVotedCandidate* obj, int t) {
    int left = 0, right = obj->size - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (obj->times[mid] == t) {
            return obj->leaders[mid];
        } else if (obj->times[mid] < t) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return obj->leaders[right];
}

void topVotedCandidateFree(TopVotedCandidate* obj) {
    free(obj->times);
    free(obj->leaders);
    free(obj);
}

/**
 * Your TopVotedCandidate struct will be instantiated and called as such:
 * TopVotedCandidate* obj = topVotedCandidateCreate(persons, personsSize, times, timesSize);
 * int param_1 = topVotedCandidateQ(obj, t);
 * topVotedCandidateFree(obj);
 */