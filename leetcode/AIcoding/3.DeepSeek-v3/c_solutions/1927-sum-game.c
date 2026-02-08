bool sumGame(char* num) {
    int n = strlen(num);
    int leftSum = 0, rightSum = 0;
    int leftCount = 0, rightCount = 0;

    for (int i = 0; i < n / 2; i++) {
        if (num[i] == '?') {
            leftCount++;
        } else {
            leftSum += num[i] - '0';
        }
    }

    for (int i = n / 2; i < n; i++) {
        if (num[i] == '?') {
            rightCount++;
        } else {
            rightSum += num[i] - '0';
        }
    }

    int totalCount = leftCount + rightCount;
    if (totalCount % 2 == 1) return true;

    int diff = leftSum - rightSum;
    int qDiff = leftCount - rightCount;

    if (diff == 0 && qDiff == 0) return false;

    if (diff * qDiff > 0) return true;

    return abs(diff) != abs(qDiff) * 9 / 2;
}