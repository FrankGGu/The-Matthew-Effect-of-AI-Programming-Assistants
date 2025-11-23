#include <string.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maxOperations(char * s) {
    int n = strlen(s);
    if (n < 2) {
        return 0;
    }

    long long prev2 = 0; // Represents max operations ending at index i-2
    long long prev1 = 0; // Represents max operations ending at index i-1

    for (int i = 1; i < n; i++) {
        long long current_val = prev1; // Option 1: Do not perform an operation using s[i] or s[i-1]
                                       // Max operations remain the same as up to index i-1

        // Option 2: If s[i-1] and s[i] form a '11' pair, we can perform an operation
        if (s[i] == '1' && s[i-1] == '1') {
            // Performing this operation adds 1 to the count
            // and we consider the maximum operations up to index i-2 (prev2)
            current_val = max(current_val, prev2 + 1);
        }

        // Update prev2 and prev1 for the next iteration
        prev2 = prev1;
        prev1 = current_val;
    }

    return prev1; // prev1 now holds the maximum operations for the entire string (up to index n-1)
}