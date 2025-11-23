int findChampion(int* A, int ASize) {
    int candidate = A[0], count = 1;

    for (int i = 1; i < ASize; i++) {
        if (A[i] == candidate) {
            count++;
        } else {
            count--;
            if (count == 0) {
                candidate = A[i];
                count = 1;
            }
        }
    }

    count = 0;
    for (int i = 0; i < ASize; i++) {
        if (A[i] == candidate) {
            count++;
        }
    }

    return count > ASize / 2 ? candidate : -1;
}