#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestInteger(int num) {
        string s = to_string(num);
        int n = s.size();
        vector<int> odd, even;
        for (char c : s) {
            int digit = c - '0';
            if (digit % 2 == 0) {
                even.push_back(digit);
            } else {
                odd.push_back(digit);
            }
        }
        sort(odd.rbegin(), odd.rend());
        sort(even.rbegin(), even.rend());

        string ans = "";
        int oddIdx = 0, evenIdx = 0;
        for (char c : s) {
            int digit = c - '0';
            if (digit % 2 == 0) {
                ans += to_string(even[evenIdx++]);
            } else {
                ans += to_string(odd[oddIdx++]);
            }
        }
        return ans;
    }
};