/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* threeEqualParts(int* arr, int arrSize, int* returnSize) {
    int countOnes = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) countOnes++;
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;
    *returnSize = 2;

    if (countOnes == 0) {
        result[0] = 0;
        result[1] = arrSize - 1;
        return result;
    }

    if (countOnes % 3 != 0) {
        return result;
    }

    int onesPerPart = countOnes / 3;
    int firstOne = -1, secondOne = -1, thirdOne = -1;
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) {
            count++;
            if (count == 1) firstOne = i;
            if (count == onesPerPart + 1) secondOne = i;
            if (count == 2 * onesPerPart + 1) thirdOne = i;
        }
    }

    int len = arrSize - thirdOne;

    if (firstOne + len > secondOne || secondOne + len > thirdOne) {
        return result;
    }

    for (int i = 0; i < len; i++) {
        if (arr[firstOne + i] != arr[secondOne + i] || arr[firstOne + i] != arr[thirdOne + i]) {
            return result;
        }
    }

    result[0] = firstOne + len - 1;
    result[1] = secondOne + len;
    return result;
}