int* addNegabinary(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int maxSize = (arr1Size > arr2Size ? arr1Size : arr2Size) + 2;
    int* result = (int*)malloc(maxSize * sizeof(int));
    int carry = 0, i = 0;

    while (i < arr1Size || i < arr2Size || carry != 0) {
        int sum = carry;
        if (i < arr1Size) sum += arr1[arr1Size - 1 - i];
        if (i < arr2Size) sum += arr2[arr2Size - 1 - i];

        if (sum >= 0) {
            result[maxSize - 1 - i] = sum % 2;
            carry = -(sum / 2);
        } else {
            result[maxSize - 1 - i] = (sum + 2) % 2;
            carry = (sum + 2) / -2;
        }
        i++;
    }

    while (maxSize > 1 && result[maxSize - 1] == 0) {
        maxSize--;
    }

    *returnSize = maxSize;
    return result + (maxSize == 0 ? 0 : (maxSize - 1));
}