#include <vector>
#include <algorithm> // Required for std::reverse

class Solution {
public:
    std::vector<int> addToArrayForm(std::vector<int>& num, int k) {
        std::vector<int> result;
        int n = num.size();
        int i = n - 1; // Pointer for num array
        int carry = 0;

        while (i >= 0 || k > 0 || carry > 0) {
            int digit_num = (i >= 0) ? num[i] : 0;
            int digit_k = k % 10;

            int sum = digit_num + digit_k + carry;
            result.push_back(sum % 10);
            carry = sum / 10;

            k /= 10;
            i--;
        }

        std::reverse(result.begin(), result.end());
        return result;
    }
};