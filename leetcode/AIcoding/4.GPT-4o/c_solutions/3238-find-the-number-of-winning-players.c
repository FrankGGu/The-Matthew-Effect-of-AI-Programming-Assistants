int countPlayers(int* scores, int scoresSize) {
    int maxScore = 0, count = 0;

    for (int i = 0; i < scoresSize; i++) {
        if (scores[i] > maxScore) {
            maxScore = scores[i];
        }
    }

    for (int i = 0; i < scoresSize; i++) {
        if (scores[i] == maxScore) {
            count++;
        }
    }

    return count;
}