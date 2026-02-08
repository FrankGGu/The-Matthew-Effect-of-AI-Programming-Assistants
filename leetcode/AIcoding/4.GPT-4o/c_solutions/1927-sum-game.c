bool sumGame(char *num) {
    int leftSum = 0, rightSum = 0, leftQuestionMarks = 0, rightQuestionMarks = 0;
    int i = 0, n = strlen(num);

    while (i < n / 2) {
        if (num[i] == '?') {
            leftQuestionMarks++;
        } else {
            leftSum += num[i] - '0';
        }
        i++;
    }

    while (i < n) {
        if (num[i] == '?') {
            rightQuestionMarks++;
        } else {
            rightSum += num[i] - '0';
        }
        i++;
    }

    int leftDiff = leftSum + (leftQuestionMarks * 9);
    int rightDiff = rightSum + (rightQuestionMarks * 9);

    return leftDiff != rightDiff && (leftDiff - rightDiff) % 9 == 0;
}