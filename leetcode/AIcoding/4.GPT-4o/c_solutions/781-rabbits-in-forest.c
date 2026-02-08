int numRabbits(int* answers, int answersSize) {
    int count[1001] = {0};
    for (int i = 0; i < answersSize; i++) {
        count[answers[i]]++;
    }
    int total = 0;
    for (int i = 0; i < 1001; i++) {
        if (count[i] > 0) {
            total += ((count[i] + i) / (i + 1)) * (i + 1);
        }
    }
    return total;
}