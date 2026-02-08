#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> addNegabinary(vector<int>& arr1, vector<int>& arr2) {
        vector<int> ans;
        int carry = 0;
        int i = arr1.size() - 1, j = arr2.size() - 1;
        while (i >= 0 || j >= 0 || carry != 0) {
            int sum = carry;
            if (i >= 0) {
                sum += arr1[i];
                i--;
            }
            if (j >= 0) {
                sum += arr2[j];
                j--;
            }

            if (sum == 0) {
                ans.push_back(0);
                carry = 0;
            } else if (sum == 1) {
                ans.push_back(1);
                carry = 0;
            } else if (sum == 2) {
                ans.push_back(0);
                carry = -1;
            } else if (sum == 3) {
                ans.push_back(1);
                carry = -1;
            } else if (sum == -1) {
                ans.push_back(1);
                carry = 1;
            }
        }

        while (ans.size() > 1 && ans.back() == 0) {
            ans.pop_back();
        }

        reverse(ans.begin(), ans.end());
        return ans;
    }
};