int numRabbits(int* answers, int answersSize) {
    int count[1000] = {0};
    for (int i = 0; i < answersSize; i++) {
        count[answers[i]]++;
    }

    int result = 0;
    for (int i = 0; i < 1000; i++) {
        if (count[i] > 0) {
            result += ((count[i] + i) / (i + 1)) * (i + 1);
        }
    }
    return result;
}