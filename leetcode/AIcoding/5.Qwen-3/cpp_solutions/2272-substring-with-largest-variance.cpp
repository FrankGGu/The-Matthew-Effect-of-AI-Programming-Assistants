#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int largestVariance(string s) {
        int maxVariance = 0;
        unordered_map<char, int> count;
        for (char c : s) count[c]++;

        for (char a : count) {
            for (char b : count) {
                if (a == b) continue;
                int var = 0;
                bool hasB = false;
                for (char c : s) {
                    if (c == a) var++;
                    else if (c == b) {
                        hasB = true;
                        var--;
                        if (var < 0) {
                            var = 0;
                            hasB = false;
                        }
                    }
                }
                if (hasB) maxVariance = max(maxVariance, var);
            }
        }
        return maxVariance;
    }
};