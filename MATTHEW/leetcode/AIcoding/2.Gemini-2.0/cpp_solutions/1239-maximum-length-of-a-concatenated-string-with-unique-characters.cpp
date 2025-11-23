#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxLength(vector<string>& arr) {
        vector<string> dp = {""};
        int ans = 0;
        for (string s : arr) {
            if (hasDuplicate(s)) continue;
            vector<string> new_dp;
            for (string t : dp) {
                string combined = t + s;
                if (!hasDuplicate(combined)) {
                    new_dp.push_back(combined);
                    ans = max(ans, (int)combined.length());
                }
            }
            for (string new_s : new_dp) {
                dp.push_back(new_s);
            }
        }
        return ans;
    }

private:
    bool hasDuplicate(string s) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
            if (count[c - 'a'] > 1) return true;
        }
        return false;
    }
};