int countOfBuildings(int* heights, int heightsSize) {
    int count = 1;
    int maxHeight = heights[0];

    for (int i = 1; i < heightsSize; i++) {
        if (heights[i] > maxHeight) {
            count++;
            maxHeight = heights[i];
        }
    }

    return count;
}