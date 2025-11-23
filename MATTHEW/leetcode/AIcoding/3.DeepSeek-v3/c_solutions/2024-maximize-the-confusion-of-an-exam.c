int maxConsecutiveAnswers(char* answerKey, int k) {
    int n = strlen(answerKey);
    int left = 0, maxCount = 0, result = 0;
    int countT = 0, countF = 0;

    for (int right = 0; right < n; right++) {
        if (answerKey[right] == 'T') countT++;
        else countF++;

        while (countT > k && countF > k) {
            if (answerKey[left] == 'T') countT--;
            else countF--;
            left++;
        }

        result = (right - left + 1) > result ? (right - left + 1) : result;
    }

    return result;
}