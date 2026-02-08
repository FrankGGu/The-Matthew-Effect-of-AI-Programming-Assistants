#include <stdlib.h> // Required for qsort and malloc

static int g_k;

int compareRows(const void* a, const void* b) {
    // 'a' and 'b' are pointers to the elements being sorted by qsort.
    // In this case, the 'score' array is of type 'int**', meaning it's an array of 'int*'.
    // So, 'a' and 'b' are 'const void*' pointers to 'int*'.
    // We cast them to 'int**' and then dereference to get the actual 'int*' (which represents a row).
    int* row1 = *(int**)a;
    int* row2 = *(int**)b;

    // Compare the elements at the global index g_k.
    // For descending order, we return (value of row2) - (value of row1).
    return row2[g_k] - row1[g_k];
}

int** sortTheStudents(int** score, int scoreSize, int* scoreColSize, int k, int* returnSize, int** returnColumnSizes) {
    // Set the global 'k' value so the comparison function can access it.
    g_k = k;

    // Use qsort to sort the array of rows.
    // - score: The base address of the array to be sorted (an array of int*).
    // - scoreSize: The number of elements in the array (number of rows).
    // - sizeof(int*): The size of each element in the array (each element is a pointer to an int array).
    // - compareRows: The custom comparison function.
    qsort(score, scoreSize, sizeof(int*), compareRows);

    // Set the returnSize to the number of rows in the sorted matrix.
    *returnSize = scoreSize;

    // Allocate memory for the array that will hold column sizes for each row.
    // This is required by LeetCode's C signature for returning 2D arrays,
    // even if the column sizes are uniform or the array is sorted in-place.
    *returnColumnSizes = (int*)malloc(sizeof(int) * scoreSize);

    // Copy the column sizes. Since it's a matrix, all rows have the same number of columns.
    // We can copy the first row's column size for all entries, or iterate through scoreColSize.
    for (int i = 0; i < scoreSize; i++) {
        (*returnColumnSizes)[i] = scoreColSize[i];
    }

    // Return the sorted matrix (which was modified in-place).
    return score;
}