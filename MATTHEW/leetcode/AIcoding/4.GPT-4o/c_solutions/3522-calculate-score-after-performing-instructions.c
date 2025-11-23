int calculateScore(int* instructions, int instructionsSize, int* queries, int queriesSize) {
    int* scores = (int*)malloc(instructionsSize * sizeof(int));
    memset(scores, 0, instructionsSize * sizeof(int));
    int totalScore = 0;

    for (int i = 0; i < instructionsSize; i++) {
        totalScore += instructions[i];
        scores[i] = totalScore;
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        if (query > 0 && query <= instructionsSize) {
            result[i] = scores[query - 1];
        } else {
            result[i] = 0;
        }
    }

    free(scores);
    return result;
}