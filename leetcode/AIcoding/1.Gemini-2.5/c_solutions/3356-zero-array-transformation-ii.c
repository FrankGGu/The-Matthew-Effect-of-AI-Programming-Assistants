#include <stdbool.h>
#include <stdlib.h> // For malloc and free

bool checkArray(int* nums, int numsSize) {
    if (numsSize == 0) {
        return true;
    }

    // Use a long long array to store the x_i values.
    // x_i represents the amount subtracted using index i as the starting point
    // of an operation (i.e., x_i is subtracted from nums[i] and nums[(i+1)%n]).
    // The problem implies a greedy strategy where we determine x_i sequentially.
    // The intermediate values in x_values can exceed int limits, so long long is necessary.
    long long* x_values = (long long*)malloc(numsSize * sizeof(long long));
    if (x_values == NULL) {
        return false; // Memory allocation failed
    }

    // Step 1: Determine x_0.
    // The greedy strategy is to choose x_0 to be exactly nums[0] (the initial value).
    // This implies that the operation at index 0 will reduce nums[0] to 0.
    // This x_0 is subtracted from nums[0] and nums[1].
    x_values[0] = nums[0];

    // Step 2: Determine x_i for i from 1 to numsSize-1.
    // For each element nums[i] (where i > 0), its value is affected by two operations:
    // 1. x_i (subtracted from nums[i] and nums[(i+1)%n])
    // 2. x_{i-1} (subtracted from nums[i-1] and nums[i])
    // To make nums[i] zero, we need x_i + x_{i-1} = initial_nums[i].
    // Since x_{i-1} is already determined from the previous step, x_i is fixed.
    // So, x_i = initial_nums[i] - x_{i-1}.
    for (int i = 1; i < numsSize; ++i) {
        x_values[i] = nums[i] - x_values[i - 1];
    }

    // Step 3: Check validity conditions.
    // For the transformation to be possible, all x_i must satisfy:
    // 1. x_i >= 0 (as per problem statement: "non-negative integer x")
    // 2. x_i <= initial_nums[i] (as per problem statement: "x <= nums[i]").
    //    This condition is implicitly satisfied if x_i >= 0 and initial_nums[i] >= 0,
    //    because x_i = initial_nums[i] - x_{i-1}. If x_{i-1} >= 0, then x_i <= initial_nums[i].
    //    Since initial_nums[i] are non-negative, we only need to check x_i >= 0.

    for (int i = 0; i < numsSize; ++i) {
        if (x_values[i] < 0) {
            free(x_values);
            return false;
        }
    }

    // Step 4: Final consistency check for the circular array.
    // The values x_0, x_1, ..., x_{n-1} were derived based on the equations:
    // x_0 = initial_nums[0] (our greedy choice)
    // x_i + x_{i-1} = initial_nums[i] for i = 1 to n-1.
    // The full system of equations for a circular array also includes:
    // x_0 + x_{n-1} = initial_nums[0].
    // We need to verify if our derived x_0 and x_{n-1} satisfy this final equation.
    // If not, the greedy choice of x_0 was not consistent with the circular nature.
    if (x_values[0] + x_values[numsSize - 1] != nums[0]) {
        free(x_values);
        return false;
    }

    // If all checks pass, a valid set of operations exists.
    free(x_values);
    return true;
}