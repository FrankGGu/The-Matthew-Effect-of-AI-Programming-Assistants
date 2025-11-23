bool canThreePartsEqualSum(int* A, int ASize) {
    int totalSum = 0;
    for (int i = 0; i < ASize; i++) {
        totalSum += A[i];
    }
    if (totalSum % 3 != 0) return false;

    int target = totalSum / 3, currentSum = 0, count = 0;
    for (int i = 0; i < ASize; i++) {
        currentSum += A[i];
        if (currentSum == target) {
            count++;
            currentSum = 0;
        }
    }
    return count >= 3;
}