#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<int> advantageShuffle(std::vector<int>& A, std::vector<int>& B) {
        int n = A.size();
        std::vector<int> result(n);

        std::sort(A.begin(), A.end());

        std::vector<std::pair<int, int>> B_indexed(n);
        for (int i = 0; i < n; ++i) {
            B_indexed[i] = {B[i], i};
        }
        std::sort(B_indexed.begin(), B_indexed.end());

        int a_ptr_low = 0;
        int a_ptr_high = n - 1;
        int b_ptr_low = 0;
        int b_ptr_high = n - 1;

        while (b_ptr_low <= b_ptr_high) {
            int b_val = B_indexed[b_ptr_low].first;
            int b_idx = B_indexed[b_ptr_low].second;

            if (A[a_ptr_low] > b_val) {
                result[b_idx] = A[a_ptr_low];
                a_ptr_low++;
                b_ptr_low++;
            } else {
                result[B_indexed[b_ptr_high].second] = A[a_ptr_low];
                a_ptr_low++;
                b_ptr_high--;
            }
        }

        return result;
    }
};