#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<bool> canMakePalindromeQueries(string s, vector<vector<int>>& queries) {
        int n = s.length();
        vector<bool> result;
        for (auto& q : queries) {
            int l = q[0], r = q[1];
            unordered_map<char, int> cnt;
            for (int i = l; i <= r; ++i) {
                cnt[s[i]]++;
            }
            bool isPossible = true;
            int oddCount = 0;
            for (auto& [c, v] : cnt) {
                if (v % 2 != 0) {
                    oddCount++;
                }
            }
            if (oddCount > 1) {
                isPossible = false;
            }
            result.push_back(isPossible);
        }
        return result;
    }
};