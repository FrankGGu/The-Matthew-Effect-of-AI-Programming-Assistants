int minCostToMoveChips(int* position, int positionSize) {
    int even_count = 0;
    int odd_count = 0;

    for (int i = 0; i < positionSize; i++) {
        if (position[i] % 2 == 0) {
            even_count++;
        } else {
            odd_count++;
        }
    }

    if (even_count < odd_count) {
        return even_count;
    } else {
        return odd_count;
    }
}