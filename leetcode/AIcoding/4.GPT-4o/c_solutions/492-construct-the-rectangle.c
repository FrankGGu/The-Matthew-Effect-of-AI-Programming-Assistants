int* constructRectangle(int area, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int width = (int)sqrt(area);

    while (area % width != 0) {
        width--;
    }

    result[0] = area / width;
    result[1] = width;
    *returnSize = 2;

    return result;
}