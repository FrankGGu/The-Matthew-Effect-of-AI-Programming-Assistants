#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isPrefixString(vector<string>& nums, string s) {
        string current;
        for (const string& str : nums) {
            current += str;
            if (current == s) {
                return true;
            }
        }
        return false;
    }
};