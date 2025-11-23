#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestNumber(vector<int>& nums) {
        vector<string> as_str;
        for (int num : nums) {
            as_str.push_back(to_string(num));
        }

        sort(as_str.begin(), as_str.end(), [](const string& a, const string& b) {
            return a + b > b + a;
        });

        if (as_str[0] == "0") {
            return "0";
        }

        string result = "";
        for (const string& s : as_str) {
            result += s;
        }

        return result;
    }
};