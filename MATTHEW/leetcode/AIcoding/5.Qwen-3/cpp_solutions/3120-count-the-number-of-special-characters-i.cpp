#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfSpecialChars(string word) {
        unordered_map<char, int> count;
        for (char c : word) {
            count[c]++;
        }
        int result = 0;
        for (auto& [c, freq] : count) {
            if (freq >= 2) {
                result++;
            }
        }
        return result;
    }
};