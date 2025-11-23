long long minimumIncrements(int* arr, int arrSize, int* target, int targetSize) {
    long long totalIncrements = 0;

    for (int i = 0; i < arrSize; i++) {
        long long currentArrVal = arr[i];
        long long currentTargetVal = target[i];

        if (currentArrVal % currentTargetVal != 0) {
            totalIncrements += currentTargetVal - (currentArrVal % currentTargetVal);
        }
    }

    return totalIncrements;
}