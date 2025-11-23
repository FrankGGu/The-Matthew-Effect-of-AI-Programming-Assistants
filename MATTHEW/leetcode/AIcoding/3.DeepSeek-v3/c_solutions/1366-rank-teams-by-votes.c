typedef struct {
    char name;
    int votes[26];
} Team;

int cmp(const void* a, const void* b) {
    Team* teamA = (Team*)a;
    Team* teamB = (Team*)b;

    for (int i = 0; i < 26; i++) {
        if (teamA->votes[i] != teamB->votes[i]) {
            return teamB->votes[i] - teamA->votes[i];
        }
    }

    return teamA->name - teamB->name;
}

char* rankTeams(char** votes, int votesSize) {
    if (votesSize == 0) return "";

    Team teams[26];
    for (int i = 0; i < 26; i++) {
        teams[i].name = 'A' + i;
        for (int j = 0; j < 26; j++) {
            teams[i].votes[j] = 0;
        }
    }

    int teamCount = strlen(votes[0]);

    for (int i = 0; i < votesSize; i++) {
        for (int j = 0; j < teamCount; j++) {
            char c = votes[i][j];
            teams[c - 'A'].votes[j]++;
        }
    }

    qsort(teams, 26, sizeof(Team), cmp);

    char* result = (char*)malloc((teamCount + 1) * sizeof(char));
    for (int i = 0; i < teamCount; i++) {
        result[i] = teams[i].name;
    }
    result[teamCount] = '\0';

    return result;
}