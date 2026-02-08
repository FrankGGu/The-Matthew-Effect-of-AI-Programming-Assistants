int max(int a, int b) {
    return a > b ? a : b;
}

int maximumEnemyForts(int* forts, int fortsSize) {
    int max_captured = 0;
    int j = 0; 

    for (int i = 0; i < fortsSize; ++i) {
        if (forts[i] != 0) { 
            if (forts[j] != 0 && forts[j] != forts[i]) {
                max_captured = max(max_captured, i - j - 1);
            }
            j = i;
        }
    }

    return max_captured;
}