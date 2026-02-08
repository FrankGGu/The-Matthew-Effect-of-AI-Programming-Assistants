#include <stdbool.h>
#include <limits.h>

bool isPowerOfThree(int n) {
    if (n <= 0) {
        return false;
    }
    // The largest power of 3 that fits in a signed 32-bit integer is 3^19 = 1162261467.
    // Any other power of 3 would be larger than INT_MAX or smaller than 1.
    // If n is a power of 3, then it must divide 3^19.
    // This is because if n = 3^k, and 3^19 is divisible by n, then 3^19 % 3^k == 0.
    // And if n is not a power of 3, it will not divide 3^19 (unless n contains factors other than 3,
    // which would make it not a power of 3 anyway, or if n is a power of 3 but larger than 3^19,
    // which is already handled by n <= 0 check and the specific value of 3^19).
    return 1162261467 % n == 0;
}