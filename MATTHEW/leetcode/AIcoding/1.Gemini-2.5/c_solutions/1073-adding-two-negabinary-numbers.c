#include <stdlib.h> // For malloc, free

int* addNegabinary(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    // A safe upper bound for the result array size.
    // In negabinary, adding two numbers can increase the length by up to 2.
    // For example, [1] + [1] = [1,1,0]. Length 1 -> 3.
    // max(arr1Size, arr2Size) + 4 provides sufficient buffer.
    int max_possible_len = (arr1Size > arr2Size ? arr1Size : arr2Size) + 4;
    int* temp_res = (int*)malloc(sizeof(int) * max_possible_len); 

    // Handle allocation failure
    if (temp_res == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int carry = 0;
    int k = 0; // Current index for temp_res (stores digits in reverse order, least significant first)
    int i = arr1Size - 1; // Pointer for arr1, starting from LSB
    int j = arr2Size - 1; // Pointer for arr2, starting from LSB

    // Loop until both arrays are exhausted and there's no carry
    while (i >= 0 || j >= 0 || carry != 0) {
        int d1 = (i >= 0) ? arr1[i] : 0;
        int d2 = (j >= 0) ? arr2[j] : 0;

        int sum = d1 + d2 + carry;

        // Negabinary addition rules:
        // sum = 0: digit = 0, new_carry = 0
        // sum = 1: digit = 1, new_carry = 0
        // sum = 2: digit = 0, new_carry = -1 (since 2 = 0 + (-1)*(-2))
        // sum = 3: digit = 1, new_carry = -1 (since 3 = 1 + (-1)*(-2))
        // sum = -1: digit = 1, new_carry = 1 (since -1 = 1 + 1*(-2))
        if (sum >= 0) {
            temp_res[k] = sum % 2;
            carry = -(sum / 2);
        } else { // sum == -1
            temp_res[k] = 1;
            carry = 1;
        }

        k++; // Move to the next position in temp_res
        i--; // Move to the next digit in arr1
        j--; // Move to the next digit in arr2
    }

    // Remove leading zeros from the result (most significant digit side)
    // k is the total number of digits stored in temp_res (in reverse order).
    // The most significant digit is at temp_res[k-1].
    int msb_idx = k - 1;
    // Iterate from the MSB towards LSB, skipping leading zeros.
    // Stop if we find a '1' or if we are at the last digit (which could be 0, e.g., result is [0]).
    while (msb_idx > 0 && temp_res[msb_idx] == 0) {
        msb_idx--;
    }

    // The actual length of the result array after removing leading zeros.
    int actual_len = msb_idx + 1;
    int* result = (int*)malloc(sizeof(int) * actual_len);

    // Handle allocation failure
    if (result == NULL) {
        *returnSize = 0;
        free(temp_res);
        return NULL;
    }

    // Copy digits from temp_res to result in the correct order (most significant first)
    // temp_res[msb_idx] is the MSB, temp_res[0] is the LSB.
    for (int p = 0; p < actual_len; p++) {
        result[p] = temp_res[msb_idx - p];
    }

    *returnSize = actual_len;
    free(temp_res); // Free the temporary array
    return result;
}