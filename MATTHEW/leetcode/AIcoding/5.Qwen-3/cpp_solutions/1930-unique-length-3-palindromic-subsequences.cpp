#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPalindromicSubsequence(string s) {
        unordered_map<char, vector<int>> pos;
        for (int i = 0; i < s.length(); ++i) {
            pos[s[i]].push_back(i);
        }

        int result = 0;
        for (auto& [c, indices] : pos) {
            int left = indices[0];
            int right = indices.back();
            unordered_set<char> uniqueChars;
            for (int i = left + 1; i < right; ++i) {
                uniqueChars.insert(s[i]);
            }
            result += uniqueChars.size();
        }

        return result;
    }
};