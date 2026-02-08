#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string findUniqueBinaryString(vector<string>& nums) {
        unordered_set<string> s;
        for (const string& num : nums) {
            s.insert(num);
        }
        int n = nums.size();
        for (int i = 0; i < (1 << n); ++i) {
            string binary = "";
            for (int j = 0; j < n; ++j) {
                binary += (i & (1 << j)) ? '1' : '0';
            }
            if (s.find(binary) == s.end()) {
                return binary;
            }
        }
        return "";
    }
};