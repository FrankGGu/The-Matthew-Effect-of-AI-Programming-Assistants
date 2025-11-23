class Solution {
public:
    long long countSetBits(long long n) {
        if (n == 0) {
            return 0;
        }
        long long totalSetBits = 0;
        // Iterate through each bit position from 0 to 60 (for long long, 2^60 is max bit)
        for (int j = 0; j < 61; ++j) {
            long long powerOf2_j = (1LL << j);
            long long powerOf2_j_plus_1 = (1LL << (j + 1));

            // Calculate the number of complete blocks of 2^(j+1) numbers up to n.
            // Each such block contributes 2^j set bits at position j.
            long long numBlocks = (n + 1) / powerOf2_j_plus_1;
            totalSetBits += numBlocks * powerOf2_j;

            // Calculate the remaining numbers after the complete blocks.
            // If the j-th bit is set in this partial block (i.e., numbers from powerOf2_j up to remainder-1),
            // count them.
            long long remainder = (n + 1) % powerOf2_j_plus_1;
            totalSetBits += std::max(0LL, remainder - powerOf2_j);
        }
        return totalSetBits;
    }

    long long findMaximumNumber(long long k) {
        long long low = 0; // Minimum possible number of items
        // A sufficiently large upper bound for N.
        // Since popcount(i) >= 1 for i >= 1, N cannot exceed K.
        // A slightly larger bound like 2*K or 4*K (considering average popcount) is safe.
        // For K = 10^15, 2*K is 2*10^15, which fits in long long.
        long long high = 2 * k + 100; 
        long long ans = 0;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (mid == 0) { // Special case for mid=0, as countSetBits(0) is 0
                if (0 <= k) {
                    ans = std::max(ans, mid);
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
                continue;
            }

            if (countSetBits(mid) <= k) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }
};