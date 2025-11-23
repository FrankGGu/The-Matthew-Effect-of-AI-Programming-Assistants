bool canThreePartsEqualSum(int* arr, int arrSize) {
    int totalSum = 0;
    for (int i = 0; i < arrSize; i++) {
        totalSum += arr[i];
    }

    if (totalSum % 3 != 0) {
        return false;
    }

    int targetSum = totalSum / 3;
    int currentSum = 0;
    int partitionsFound = 0;

    for (int i = 0; i < arrSize; i++) {
        currentSum += arr[i];
        if (currentSum == targetSum) {
            partitionsFound++;
            currentSum = 0;
            if (partitionsFound == 2 && i < arrSize - 1) {
                return true;
            }
        }
    }

    return false;
}