int numOfUnplacedFruits(int* fruits, int fruitsSize, int* baskets, int basketsSize) {
    int* placed = (int*)calloc(fruitsSize, sizeof(int));
    int unplaced = 0;

    for (int i = 0; i < fruitsSize; i++) {
        int found = 0;
        for (int j = 0; j < basketsSize; j++) {
            if (baskets[j] >= fruits[i] && !placed[i]) {
                baskets[j] = 0;
                placed[i] = 1;
                found = 1;
                break;
            }
        }
        if (!found) {
            unplaced++;
        }
    }

    free(placed);
    return unplaced;
}