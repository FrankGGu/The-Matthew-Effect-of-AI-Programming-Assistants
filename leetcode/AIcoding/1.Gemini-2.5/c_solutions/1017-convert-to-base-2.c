#include <stdlib.h> // For malloc

char* baseNeg2(int n) {
    if (n == 0) {
        char* result = (char*)malloc(sizeof(char) * 2);
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    char buffer[50]; // A buffer to store digits in reverse order. Max length for 10^9 is 35 digits. 50 is safe.
    int i = 0;

    while (n != 0) {
        int remainder = n % 2;
        if (remainder < 0) {
            remainder += 2; // Adjust negative remainder to be 0 or 1
        }
        buffer[i++] = remainder + '0';
        n = (n - remainder) / (-2); // Calculate the next n
    }

    // The digits are stored in reverse order in buffer.
    // Allocate memory for the final string and copy digits in correct order.
    char* result = (char*)malloc(sizeof(char) * (i + 1));
    if (result == NULL) {
        return NULL; // Handle allocation failure
    }

    // Copy digits from buffer to result in reverse (correct) order
    for (int j = 0; j < i; j++) {
        result[j] = buffer[i - 1 - j];
    }
    result[i] = '\0'; // Null-terminate the string

    return result;
}