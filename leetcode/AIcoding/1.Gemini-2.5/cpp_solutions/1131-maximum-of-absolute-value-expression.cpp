#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int maxAbsValExpr(std::vector<int>& arr1, std::vector<int>& arr2) {
        int n = arr1.size();
        int max_overall = 0;

        // Iterate through all 8 combinations of signs for s1, s2, s3
        // s1 corresponds to arr1[k], s2 to arr2[k], s3 to k (index)
        // The expression |A| + |B| + |C| can be rewritten as
        // max_{s_A, s_B, s_C in {-1, 1}} (s_A * A + s_B * B + s_C * C)
        // Here, A = arr1[i] - arr1[j], B = arr2[i] - arr2[j], C = i - j
        // So we maximize s1*(arr1[i]-arr1[j]) + s2*(arr2[i]-arr2[j]) + s3*(i-j)
        // which is equivalent to maximizing (s1*arr1[i] + s2*arr2[i] + s3*i) - (s1*arr1[j] + s2*arr2[j] + s3*j)
        // For a fixed set of (s1, s2, s3), let f(k) = s1*arr1[k] + s2*arr2[k] + s3*k
        // We want to maximize f(i) - f(j), which is max(f(k)) - min(f(k)) over all k.
        for (int s1 = -1; s1 <= 1; s1 += 2) {
            for (int s2 = -1; s2 <= 1; s2 += 2) {
                for (int s3 = -1; s3 <= 1; s3 += 2) {
                    int current_max_f = std::numeric_limits<int>::min();
                    int current_min_f = std::numeric_limits<int>::max();

                    for (int k = 0; k < n; ++k) {
                        int f_k = s1 * arr1[k] + s2 * arr2[k] + s3 * k;
                        current_max_f = std::max(current_max_f, f_k);
                        current_min_f = std::min(current_min_f, f_k);
                    }
                    max_overall = std::max(max_overall, current_max_f - current_min_f);
                }
            }
        }
        return max_overall;
    }
};