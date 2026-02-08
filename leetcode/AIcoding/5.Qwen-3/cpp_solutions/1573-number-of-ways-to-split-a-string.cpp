#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numWays(string s) {
        int n = s.length();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (s[i] == '1' ? 1 : 0);
        }
        int totalOnes = prefix[n];
        if (totalOnes % 2 != 0) return 0;
        if (totalOnes == 0) return (n - 1) * (n - 2) / 2;
        int half = totalOnes / 2;
        int count = 0;
        for (int i = 1; i < n; ++i) {
            if (prefix[i] == half) {
                count++;
            }
        }
        return count;
    }
};