#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canConstruct(string s, int k) {
        if (k > s.length()) return false;
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        int oddCount = 0;
        for (auto& pair : count) {
            if (pair.second % 2 != 0) {
                oddCount++;
            }
        }
        return oddCount <= k;
    }
};