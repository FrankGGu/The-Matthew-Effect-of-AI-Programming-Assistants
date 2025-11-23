int* constructRectangle(int area, int* returnSize) {
    int *result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int width = (int)sqrt(area);
    while (area % width != 0) {
        width--;
    }

    result[0] = area / width;
    result[1] = width;

    return result;
}