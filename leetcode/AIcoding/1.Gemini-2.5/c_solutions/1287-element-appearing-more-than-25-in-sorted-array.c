int findSpecialInteger(int* arr, int arrSize) {
    int quarter = arrSize / 4;

    for (int i = 0; i < arrSize - quarter; i++) {
        if (arr[i] == arr[i + quarter]) {
            return arr[i];
        }
    }

    return -1; 
}