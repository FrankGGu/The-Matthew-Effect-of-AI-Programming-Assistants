#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int numberOfUniqueGoodSubsequences(string s) {
        int n = s.size();
        unordered_set<string> uniqueSubs;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                string sub = s.substr(i, j - i);
                bool isGood = true;
                for (int k = 0; k < sub.size(); ++k) {
                    if (sub[k] == 'a' || sub[k] == 'b') continue;
                    isGood = false;
                    break;
                }
                if (isGood) {
                    uniqueSubs.insert(sub);
                }
            }
        }
        return uniqueSubs.size();
    }
};