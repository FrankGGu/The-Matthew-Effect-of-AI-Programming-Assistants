#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestNumber(int n, vector<int>& nums) {
        if (n == 0) return "0";
        vector<string> strNums;
        for (int num : nums) {
            strNums.push_back(to_string(num));
        }
        sort(strNums.begin(), strNums.end(), [](const string& a, const string& b) {
            return a + b > b + a;
        });
        string result;
        for (const string& s : strNums) {
            result += s;
        }
        return result[0] == '0' ? "0" : result;
    }
};