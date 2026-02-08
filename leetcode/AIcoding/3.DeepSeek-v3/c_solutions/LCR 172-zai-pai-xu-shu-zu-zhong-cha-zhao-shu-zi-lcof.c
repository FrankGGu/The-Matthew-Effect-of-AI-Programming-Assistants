int countTarget(int* scores, int scoresSize, int target) {
    int count = 0;
    for (int i = 0; i < scoresSize; i++) {
        if (scores[i] == target) {
            count++;
        }
    }
    return count;
}