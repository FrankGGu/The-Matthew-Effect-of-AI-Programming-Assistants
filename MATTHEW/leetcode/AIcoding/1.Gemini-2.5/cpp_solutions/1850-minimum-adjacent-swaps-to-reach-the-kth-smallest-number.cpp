#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int getMinSwaps(std::string num, int k) {
        std::string original_num_copy = num;
        std::string target_num = num;

        for (int i = 0; i < k; ++i) {
            std::next_permutation(target_num.begin(), target_num.end());
        }

        int n = num.length();
        int swaps = 0;

        for (int i = 0; i < n; ++i) {
            if (original_num_copy[i] == target_num[i]) {
                continue;
            }

            int j = i + 1;
            while (j < n && original_num_copy[j] != target_num[i]) {
                j++;
            }

            for (int l = j; l > i; --l) {
                std::swap(original_num_copy[l], original_num_copy[l - 1]);
                swaps++;
            }
        }

        return swaps;
    }
};