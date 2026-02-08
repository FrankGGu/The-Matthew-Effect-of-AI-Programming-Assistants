#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string specialSubstrings(string s, int k) {
        unordered_map<string, int> count;
        int n = s.length();
        for (int i = 0; i <= n - k; ++i) {
            string sub = s.substr(i, k);
            count[sub]++;
        }
        for (auto& [key, val] : count) {
            if (val > 1) {
                return key;
            }
        }
        return "";
    }
};