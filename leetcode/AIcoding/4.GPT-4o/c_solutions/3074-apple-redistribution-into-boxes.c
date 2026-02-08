int minBoxes(int* apples, int applesSize) {
    int total = 0;
    for (int i = 0; i < applesSize; i++) {
        total += apples[i];
    }
    int boxes = (total + 1) / 2;
    return boxes;
}