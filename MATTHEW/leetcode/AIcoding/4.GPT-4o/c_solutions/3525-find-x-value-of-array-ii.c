int findX(int* arr1, int arr1Size, int* arr2, int arr2Size, int x) {
    int count = 0;
    for (int i = 0; i < arr1Size; i++) {
        if (arr1[i] == x) count++;
    }
    for (int j = 0; j < arr2Size; j++) {
        if (arr2[j] == x) count++;
    }
    return count;
}