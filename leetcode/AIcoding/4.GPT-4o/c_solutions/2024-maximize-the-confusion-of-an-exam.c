int maxConsecutiveAnswers(char * answerKey, int k) {
    int max_length = 0;
    int countT = 0, countF = 0;
    int left = 0;

    for (int right = 0; answerKey[right] != '\0'; right++) {
        if (answerKey[right] == 'T') {
            countT++;
        } else {
            countF++;
        }

        while (countT > k && countF > k) {
            if (answerKey[left] == 'T') {
                countT--;
            } else {
                countF--;
            }
            left++;
        }

        max_length = fmax(max_length, right - left + 1);
    }

    return max_length;
}