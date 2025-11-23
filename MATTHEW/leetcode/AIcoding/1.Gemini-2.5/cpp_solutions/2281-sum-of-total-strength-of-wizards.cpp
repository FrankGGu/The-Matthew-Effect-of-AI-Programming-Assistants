#include <vector>
#include <stack>
#include <numeric>

class Solution {
public:
    int totalStrength(std::vector<int>& strength) {
        int n = strength.size();
        long long MOD = 1e9 + 7;

        // Calculate prefix sums
        // P[i] = strength[0] + ... + strength[i-1] (modulo MOD)
        std::vector<long long> P(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            P[i+1] = (P[i] + strength[i]) % MOD;
        }

        // Calculate double prefix sums (prefix sums of P)
        // PP[i] = P[0] + ... + P[i-1] (modulo MOD)
        std::vector<long long> PP(n + 2, 0);
        for (int i = 0; i <= n; ++i) {
            PP[i+1] = (PP[i] + P[i]) % MOD;
        }

        // Calculate L (previous less or equal) and R (next strictly less)
        // L[i]: index of the first element to the left of i that is <= strength[i]. If none, -1.
        // R[i]: index of the first element to the right of i that is < strength[i]. If none, n.
        std::vector<int> L(n);
        std::vector<int> R(n);

        std::stack<int> s;
        for (int i = 0; i < n; ++i) {
            while (!s.empty() && strength[s.top()] > strength[i]) {
                s.pop();
            }
            L[i] = s.empty() ? -1 : s.top();
            s.push(i);
        }

        while (!s.empty()) s.pop(); // Clear stack for next use

        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && strength[s.top()] >= strength[i]) { // Use >= to ensure strictly less for R
                s.pop();
            }
            R[i] = s.empty() ? n : s.top();
            s.push(i);
        }

        long long total_strength_sum = 0;

        for (int i = 0; i < n; ++i) {
            long long left_bound = L[i] + 1; // Inclusive start index for subarrays
            long long right_bound = R[i] - 1; // Inclusive end index for subarrays

            // Number of elements in the left part (from left_bound to i, inclusive)
            long long count_left = i - left_bound + 1;
            // Number of elements in the right part (from i to right_bound, inclusive)
            long long count_right = right_bound - i + 1;

            // Sum of P[k+1] for k from i to right_bound
            // This is P[i+1] + P[i+2] + ... + P[right_bound+1]
            // Using PP: PP[right_bound + 2] - PP[i+1]
            long long sum_P_k_plus_1 = (PP[right_bound + 2] - PP[i+1] + MOD) % MOD;

            // Sum of P[j] for j from left_bound to i
            // This is P[left_bound] + P[left_bound+1] + ... + P[i]
            // Using PP: PP[i+1] - PP[left_bound]
            long long sum_P_j = (PP[i+1] - PP[left_bound] + MOD) % MOD;

            // Calculate S_i = sum_{j=left_bound}^{i} sum_{k=i}^{right_bound} (P[k+1] - P[j])
            // S_i = (count_left * sum_{k=i}^{right_bound} P[k+1]) - (count_right * sum_{j=left_bound}^{i} P[j])
            long long term1 = (count_left * sum_P_k_plus_1) % MOD;
            long long term2 = (count_right * sum_P_j) % MOD;

            long long S_i = (term1 - term2 + MOD) % MOD;

            total_strength_sum = (total_strength_sum + (strength[i] * S_i) % MOD) % MOD;
        }

        return static_cast<int>(total_strength_sum);
    }
};