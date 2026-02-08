#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> addToArrayForm(vector<int>& num, int k) {
        vector<int> result;
        int i = num.size() - 1;
        int carry = 0;

        while (i >= 0 || k > 0 || carry > 0) {
            int digit_num = (i >= 0) ? num[i] : 0;
            int digit_k = (k > 0) ? k % 10 : 0;
            k /= 10;

            int sum = digit_num + digit_k + carry;
            result.push_back(sum % 10);
            carry = sum / 10;

            if (i >= 0) {
                i--;
            }
        }

        reverse(result.begin(), result.end());
        return result;
    }
};