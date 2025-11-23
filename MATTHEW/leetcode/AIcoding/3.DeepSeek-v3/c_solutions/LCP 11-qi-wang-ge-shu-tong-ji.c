int expectNumber(int* scores, int scoresSize) {
    int count[1000001] = {0};
    int unique = 0;
    for (int i = 0; i < scoresSize; i++) {
        if (count[scores[i]] == 0) {
            unique++;
        }
        count[scores[i]]++;
    }
    return unique;
}