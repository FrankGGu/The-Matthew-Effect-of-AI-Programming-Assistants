char* findChampion(int* votes, int votesSize) {
    int count[1001] = {0};
    for (int i = 0; i < votesSize; i++) {
        count[votes[i]]++;
    }

    int maxVotes = 0;
    int champion = -1;
    for (int i = 0; i < 1001; i++) {
        if (count[i] > maxVotes) {
            maxVotes = count[i];
            champion = i;
        }
    }

    char* result = (char*)malloc(12 * sizeof(char));
    sprintf(result, "%d", champion);
    return result;
}