#include <stdlib.h> // For qsort, llabs
#include <limits.h> // For LLONG_MAX

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int compareFactories(const void *a, const void *b) {
    // a and b are pointers to elements of the array being sorted.
    // The array is `int** factory`, so elements are `int*`.
    // Thus, a and b are `const void*` which point to `int*`.
    // We need to cast them to `int**` to dereference them to `int*`.
    int *const *pa = (int *const *)a;
    int *const *pb = (int *const *)b;
    return (pa[0][0] - pb[0][0]); // Compare by factory position (first element of inner array)
}

long long minimumTotalDistance(int* robots, int robotsSize, int** factory, int factorySize, int* factoryColSize) {
    // Sort robots by their positions
    qsort(robots, robotsSize, sizeof(int), compareInts);

    // Sort factories by their positions
    qsort(factory, factorySize, sizeof(int*), compareFactories);

    // dp[i][j] represents the minimum cost to repair the first 'i' robots
    // using a subset of the first 'j' factories.
    // i ranges from 0 to robotsSize (inclusive)
    // j ranges from 0 to factorySize (inclusive)
    long long dp[robotsSize + 1][factorySize + 1];

    // Initialize dp table with a very large value (infinity)
    for (int i = 0; i <= robotsSize; ++i) {
        for (int j = 0; j <= factorySize; ++j) {
            dp[i][j] = LLONG_MAX;
        }
    }

    // Base case: 0 robots require 0 cost to repair, regardless of how many factories are available.
    for (int j = 0; j <= factorySize; ++j) {
        dp[0][j] = 0;
    }

    // Fill the DP table
    for (int i = 1; i <= robotsSize; ++i) { // Iterate through the number of robots to be repaired (1 to robotsSize)
        for (int j = 1; j <= factorySize; ++j) { // Iterate through the available factories (1 to factorySize)
            // Option 1: Do not use the j-th factory (factory[j-1] in 0-indexed array)
            // In this case, the first 'i' robots must be repaired using only the first 'j-1' factories.
            dp[i][j] = dp[i][j-1];

            // Option 2: Use the j-th factory (factory[j-1]) to repair some robots.
            // We consider repairing 'k' robots (from robots[i-k] to robots[i-1]) using factory[j-1].
            long long current_factory_cost = 0;
            int factory_pos = factory[j-1][0];
            int factory_capacity = factory[j-1][1];

            // Iterate 'k' from 1 up to the minimum of 'i' (number of robots remaining to be assigned)
            // and the current factory's capacity.
            for (int k = 1; k <= i && k <= factory_capacity; ++k) {
                // Add the cost of repairing the (i-k)-th robot (0-indexed) at the current factory.
                // Note: robots are 0-indexed, so robots[i-k] is the k-th robot from the end of the first 'i' robots.
                current_factory_cost += llabs((long long)robots[i-k] - factory_pos);

                // If the state dp[i-k][j-1] is reachable (not LLONG_MAX),
                // it means the first (i-k) robots could be repaired by the first (j-1) factories.
                if (dp[i-k][j-1] != LLONG_MAX) {
                    // Update dp[i][j] with the minimum cost found so far.
                    // The cost is dp[i-k][j-1] (cost for previous robots/factories)
                    // plus current_factory_cost (cost for 'k' robots at current factory).
                    dp[i][j] = (dp[i][j] < dp[i-k][j-1] + current_factory_cost) ? dp[i][j] : (dp[i-k][j-1] + current_factory_cost);
                }
            }
        }
    }

    // The final answer is the minimum cost to repair all 'robotsSize' robots
    // using all 'factorySize' factories.
    return dp[robotsSize][factorySize];
}