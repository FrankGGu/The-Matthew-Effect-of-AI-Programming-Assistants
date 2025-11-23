#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool hasAllCodesToK(string s, int k) {
        int n = s.size();
        if (k > n) return false;
        unordered_set<string> seen;
        for (int i = 0; i <= n - k; ++i) {
            seen.insert(s.substr(i, k));
        }
        return seen.size() == (1 << k);
    }
};