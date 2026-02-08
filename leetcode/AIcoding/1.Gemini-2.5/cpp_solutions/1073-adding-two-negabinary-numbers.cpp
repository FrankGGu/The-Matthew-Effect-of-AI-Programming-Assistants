#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<int> addNegabinary(std::vector<int>& arr1, std::vector<int>& arr2) {
        std::vector<int> ans;
        int carry = 0;
        int i = arr1.size() - 1;
        int j = arr2.size() - 1;

        while (i >= 0 || j >= 0 || carry != 0) {
            int d1 = (i >= 0) ? arr1[i--] : 0;
            int d2 = (j >= 0) ? arr2[j--] : 0;

            int current_sum = d1 + d2 + carry;

            // In negabinary (base -2), a digit is 0 or 1.
            // current_sum = result_digit + carry_out * (-2)
            // result_digit = (current_sum % 2 + 2) % 2 ensures result_digit is 0 or 1
            int result_digit = (current_sum % 2 + 2) % 2;

            // carry_out = (current_sum - result_digit) / (-2)
            carry = (current_sum - result_digit) / (-2);

            ans.push_back(result_digit);
        }

        // Remove leading zeros, unless the result is just "0"
        while (ans.size() > 1 && ans.back() == 0) {
            ans.pop_back();
        }

        std::reverse(ans.begin(), ans.end());
        return ans;
    }
};