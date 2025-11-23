#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> findThePrefixCommonArray(std::vector<int>& perm, std::vector<int>& arr) {
        int n = perm.size();
        std::vector<int> P(n);
        std::vector<bool> seen_perm(n, false);
        std::vector<bool> seen_arr(n, false);
        int common_count = 0;

        for (int i = 0; i < n; ++i) {
            int p_val = perm[i];
            int a_val = arr[i];

            if (!seen_perm[p_val]) {
                seen_perm[p_val] = true;
                if (seen_arr[p_val]) {
                    common_count++;
                }
            }

            if (!seen_arr[a_val]) {
                seen_arr[a_val] = true;
                if (seen_perm[a_val]) {
                    common_count++;
                }
            }

            P[i] = common_count;
        }

        return P;
    }
};