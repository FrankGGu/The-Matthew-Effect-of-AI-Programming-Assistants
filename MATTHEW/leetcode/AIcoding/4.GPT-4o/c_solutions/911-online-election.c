typedef struct {
    char *name;
    int votes;
} Candidate;

Candidate* createCandidate(char *name) {
    Candidate *candidate = (Candidate *)malloc(sizeof(Candidate));
    candidate->name = name;
    candidate->votes = 0;
    return candidate;
}

struct VotingSystem {
    Candidate **candidates;
    int candidateCount;
    int totalVotes;
    int *voteTimes;
    int time;
};

struct VotingSystem* votingSystemCreate(char **names, int namesSize) {
    struct VotingSystem *votingSystem = (struct VotingSystem *)malloc(sizeof(struct VotingSystem));
    votingSystem->candidates = (Candidate **)malloc(namesSize * sizeof(Candidate *));
    votingSystem->candidateCount = namesSize;
    votingSystem->totalVotes = 0;
    votingSystem->voteTimes = (int *)malloc(namesSize * sizeof(int));
    votingSystem->time = 0;

    for (int i = 0; i < namesSize; i++) {
        votingSystem->candidates[i] = createCandidate(names[i]);
        votingSystem->voteTimes[i] = 0;
    }
    return votingSystem;
}

void votingSystemVote(struct VotingSystem* obj, char* name, int t) {
    for (int i = 0; i < obj->candidateCount; i++) {
        if (strcmp(obj->candidates[i]->name, name) == 0) {
            obj->candidates[i]->votes++;
            obj->voteTimes[i] = t;
            obj->totalVotes++;
            obj->time = t;
            break;
        }
    }
}

char* votingSystemGetWinner(struct VotingSystem* obj) {
    int maxVotes = -1;
    int maxVoteIndex = -1;

    for (int i = 0; i < obj->candidateCount; i++) {
        if (obj->candidates[i]->votes > maxVotes ||
            (obj->candidates[i]->votes == maxVotes && obj->voteTimes[i] > obj->voteTimes[maxVoteIndex])) {
            maxVotes = obj->candidates[i]->votes;
            maxVoteIndex = i;
        }
    }
    return obj->candidates[maxVoteIndex]->name;
}

void votingSystemFree(struct VotingSystem* obj) {
    for (int i = 0; i < obj->candidateCount; i++) {
        free(obj->candidates[i]);
    }
    free(obj->candidates);
    free(obj->voteTimes);
    free(obj);
}