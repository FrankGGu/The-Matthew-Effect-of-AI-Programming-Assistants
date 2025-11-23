bool canArrange(int* arr, int arrSize) {
    if (arrSize % 2 != 0) return false;

    int count[100] = {0};
    for (int i = 0; i < arrSize; i++) {
        count[(arr[i] % 100 + 100) % 100]++;
    }

    for (int i = 1; i < 50; i++) {
        if (count[i] != count[100 - i]) return false;
    }

    return count[0] % 2 == 0;
}