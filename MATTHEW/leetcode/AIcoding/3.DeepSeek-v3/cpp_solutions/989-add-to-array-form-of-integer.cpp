class Solution {
public:
    vector<int> addToArrayForm(vector<int>& num, int k) {
        vector<int> res;
        int carry = 0;
        int i = num.size() - 1;
        while (i >= 0 || k > 0 || carry > 0) {
            int digit = carry;
            if (i >= 0) {
                digit += num[i];
                i--;
            }
            if (k > 0) {
                digit += k % 10;
                k /= 10;
            }
            carry = digit / 10;
            res.push_back(digit % 10);
        }
        reverse(res.begin(), res.end());
        return res;
    }
};