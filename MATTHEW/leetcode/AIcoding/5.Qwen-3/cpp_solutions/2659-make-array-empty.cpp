#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMinimumOperations(string s) {
        if (s.length() < 2) return -1;
        int operations = 0;
        for (int i = 1; i < s.length(); ++i) {
            if (s[i] == s[i - 1]) {
                operations++;
            }
        }
        return operations;
    }
};