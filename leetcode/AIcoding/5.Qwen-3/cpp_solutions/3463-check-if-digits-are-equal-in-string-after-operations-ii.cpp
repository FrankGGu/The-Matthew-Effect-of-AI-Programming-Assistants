#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool areDigitsEqual(string s) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        int first = -1;
        for (auto& [c, cnt] : count) {
            if (first == -1) {
                first = cnt;
            } else {
                if (cnt != first) {
                    return false;
                }
            }
        }
        return true;
    }
};