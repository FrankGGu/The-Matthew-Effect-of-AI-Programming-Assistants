int* rearrangeFruits(int* fruits, int fruitsSize, int* returnSize) {
    int* result = (int*)malloc(fruitsSize * sizeof(int));
    int left = 0, right = fruitsSize - 1;
    int index = 0;

    while (left <= right) {
        if (fruits[left] % 2 == 0) {
            result[index++] = fruits[left++];
        } else {
            left++;
        }

        if (left <= right && fruits[right] % 2 != 0) {
            result[index++] = fruits[right--];
        } else {
            right--;
        }
    }

    *returnSize = index;
    return result;
}