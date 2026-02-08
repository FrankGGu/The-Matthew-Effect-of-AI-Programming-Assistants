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
        vector<int> prefix(26, 0);

        for (int i = 0; i < n; ++i) {
            prefix[s[i] - 'a']++;
        }

        for (auto& q : queries) {
            int l = q[0], r = q[1];
            vector<int> cnt(26, 0);
            for (int i = l; i <= r; ++i) {
                cnt[s[i] - 'a']++;
            }

            bool possible = true;
            for (int i = 0; i < 26; ++i) {
                if (cnt[i] % 2 != 0) {
                    possible = false;
                    break;
                }
            }
            result.push_back(possible);
        }

        return result;
    }
};