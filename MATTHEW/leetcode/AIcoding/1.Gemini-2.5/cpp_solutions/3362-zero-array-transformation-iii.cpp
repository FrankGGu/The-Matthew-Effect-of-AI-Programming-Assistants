#include <vector>
#include <numeric>

class Solution {
public:
    int minOperations(std::vector<int>& nums) {
        std::vector<long long> A;
        A.push_back(0);
        for (int val : nums) {
            A.push_back(val);
        }
        A.push_back(0);

        if (A.size() <= 2) {
            return 0;
        }

        int ops = 0;
        int prev_sign = 0;

        for (size_t i = 1; i < A.size(); ++i) {
            long long diff = A[i] - A[i - 1];
            int current_sign = 0;
            if (diff > 0) {
                current_sign = 1;
            } else if (diff < 0) {
                current_sign = -1;
            }

            if (current_sign == 0) {
                continue;
            }

            if (prev_sign == 0) {
                ops = 1;
            } else if (current_sign != prev_sign) {
                ops++;
            }

            prev_sign = current_sign;
        }

        return ops;
    }
};