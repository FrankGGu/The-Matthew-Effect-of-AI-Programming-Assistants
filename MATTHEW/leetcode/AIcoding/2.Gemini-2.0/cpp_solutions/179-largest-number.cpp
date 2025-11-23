#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestNumber(vector<int>& nums) {
        vector<string> strs;
        for (int num : nums) {
            strs.push_back(to_string(num));
        }

        sort(strs.begin(), strs.end(), [](const string& a, const string& b) {
            return a + b > b + a;
        });

        string result = "";
        for (const string& str : strs) {
            result += str;
        }

        if (result[0] == '0' && result.length() > 1) {
            return "0";
        }

        return result;
    }
};