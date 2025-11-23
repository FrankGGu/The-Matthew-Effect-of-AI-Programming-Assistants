#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canRearrange(string s, string target, int k) {
        if (s.length() < target.length()) return false;
        if (k == 0) return false;

        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }

        for (int i = 0; i < target.length(); i++) {
            if (count[target[i]] <= 0) return false;
            count[target[i]]--;
        }

        return true;
    }
};