#define MAX_N 100005
#define MAX_LOG_K 31 // Covers k up to 2^30 - 1. Since k is up to 10^9 (< 2^30), 30 bits are needed. MAX_LOG_K=31 means j goes from 0 to 30.

int next_node[MAX_LOG_K][MAX_N];
long long dp[MAX_LOG_K][MAX_N];

long long maxFunctionValue(int* p, int pSize, long long k) {
    // Initialize base cases for j = 0 (single jump)
    // next_node[0][i] is the node reached after 1 jump from i
    // dp[0][i] is the value of the node reached after 1 jump from i (which is its index p[i])
    for (int i = 0; i < pSize; ++i) {
        next_node[0][i] = p[i];
        dp[0][i] = p[i];
    }

    // Fill the binary lifting tables
    // dp[j][i] stores the sum of values of nodes visited during 2^j jumps starting from i (excluding i)
    // next_node[j][i] stores the node reached after taking 2^j jumps starting from i
    for (int j = 1; j < MAX_LOG_K; ++j) {
        for (int i = 0; i < pSize; ++i) {
            // To take 2^j jumps from i:
            // First take 2^(j-1) jumps from i to reach an intermediate node.
            // Then take another 2^(j-1) jumps from that intermediate node.
            next_node[j][i] = next_node[j-1][next_node[j-1][i]];
            // The sum for 2^j jumps is the sum for the first 2^(j-1) jumps
            // plus the sum for the second 2^(j-1) jumps starting from the intermediate node.
            dp[j][i] = dp[j-1][i] + dp[j-1][next_node[j-1][i]];
        }
    }

    long long max_val = 0;

    // Iterate through all possible starting nodes
    for (int start_node = 0; start_node < pSize; ++start_node) {
        // The function value includes the starting node itself
        long long current_sum = start_node;
        int current_node = start_node;
        long long temp_k = k; // Use a temporary k for bit manipulation

        // Apply binary lifting to sum values for k jumps
        // Iterate from the largest power of 2 down to 0
        for (int j = MAX_LOG_K - 1; j >= 0; --j) {
            // If the j-th bit of k is set, it means we need to take 2^j jumps
            if ((temp_k >> j) & 1) {
                // Add the sum of values for these 2^j jumps
                current_sum += dp[j][current_node];
                // Move to the new current node after these 2^j jumps
                current_node = next_node[j][current_node];
            }
        }

        // Update the overall maximum value found
        if (current_sum > max_val) {
            max_val = current_sum;
        }
    }

    return max_val;
}