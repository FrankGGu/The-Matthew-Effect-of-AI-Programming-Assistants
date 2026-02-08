#include <vector>
#include <numeric>

class Solution {
public:
    int countTriplets(std::vector<int>& arr) {
        int n = arr.size();
        std::vector<int> prefix_xor(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int k = i; k < n; ++k) {
                if (prefix_xor[k + 1] == prefix_xor[i]) {
                    count += (k - i);
                }
            }
        }
        return count;
    }
};