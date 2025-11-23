#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> addNegabinary(vector<int>& a, vector<int>& b) {
        vector<int> result;
        int i = a.size() - 1, j = b.size() - 1;
        int carry = 0;

        while (i >= 0 || j >= 0 || carry != 0) {
            int sum = carry;
            if (i >= 0) sum += a[i--];
            if (j >= 0) sum += b[j--];

            result.push_back(sum & 1);
            carry = -(sum >> 1);
        }

        while (result.size() > 1 && result.back() == 0) {
            result.pop_back();
        }

        reverse(result.begin(), result.end());
        return result;
    }
};