#include <string>
#include <vector>

class Solution {
public:
    std::string getPermutation(int n, int k) {
        std::string result = "";
        std::vector<int> factorials(n + 1);
        std::vector<int> digits;

        factorials[0] = 1;
        for (int i = 1; i <= n; ++i) {
            factorials[i] = factorials[i - 1] * i;
            digits.push_back(i);
        }

        k--; 

        for (int i = n; i >= 1; --i) {
            int fact_block_size = factorials[i - 1];
            int index = k / fact_block_size;
            result += std::to_string(digits[index]);
            digits.erase(digits.begin() + index);
            k %= fact_block_size;
        }

        return result;
    }
};