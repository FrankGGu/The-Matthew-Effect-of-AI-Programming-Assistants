int* numOfBurgers(int tomatoSlices, int cheeseSlices, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;

    if (tomatoSlices % 2 != 0 || tomatoSlices < 2 * cheeseSlices || tomatoSlices > 4 * cheeseSlices) {
        *returnSize = 0;
        return result;
    }

    int jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
    int small = cheeseSlices - jumbo;

    if (jumbo >= 0 && small >= 0 && 4 * jumbo + 2 * small == tomatoSlices) {
        result[0] = jumbo;
        result[1] = small;
    } else {
        *returnSize = 0;
    }

    return result;
}