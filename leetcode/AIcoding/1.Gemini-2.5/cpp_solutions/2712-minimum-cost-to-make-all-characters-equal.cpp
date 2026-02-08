class Solution {
public:
    long long minimumCost(std::string s) {
        int n = s.length();
        long long total_cost = 0;

        for (int i = 0; i < n - 1; ++i) {
            if (s[i] != s[i+1]) {
                // If s[i] and s[i+1] are different, we must perform an operation
                // to make them equal.
                // Option 1: Flip the prefix s[0...i]. Cost is i + 1.
                // This changes s[i] to match s[i+1].
                // Option 2: Flip the suffix s[i+1...n-1]. Cost is n - (i + 1).
                // This changes s[i+1] to match s[i].
                // We choose the cheaper of these two options.
                total_cost += std::min((long long)i + 1, (long long)n - (i + 1));
            }
        }

        return total_cost;
    }
};