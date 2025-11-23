#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minSteps(string s, string t) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        for (char c : t) {
            count[c]--;
        }
        int steps = 0;
        for (auto& pair : count) {
            steps += abs(pair.second);
        }
        return steps;
    }
};