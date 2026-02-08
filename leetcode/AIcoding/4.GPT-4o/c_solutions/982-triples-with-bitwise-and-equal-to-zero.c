int countTriplets(int* arr, int arrSize) {
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            for (int k = 0; k < arrSize; k++) {
                if ((arr[i] & arr[j] & arr[k]) == 0) {
                    count++;
                }
            }
        }
    }
    return count;
}