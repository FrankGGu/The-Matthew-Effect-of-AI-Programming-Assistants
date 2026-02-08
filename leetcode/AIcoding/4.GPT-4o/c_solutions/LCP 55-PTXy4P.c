int maxFruits(int** fruits, int fruitsSize, int* fruitsColSize) {
    int max_fruits = 0;
    for (int i = 0; i < fruitsSize; i++) {
        int count = 0;
        for (int j = i; j < fruitsSize; j++) {
            if (fruits[j][0] >= fruits[i][0] && fruits[j][1] >= fruits[i][1]) {
                count += fruits[j][2];
            }
        }
        if (count > max_fruits) {
            max_fruits = count;
        }
    }
    return max_fruits;
}