#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    string rankTeams(vector<vector<char>>& votes) {
        int n = votes.size();
        if (n == 0) return "";
        int k = votes[0].size();
        map<char, vector<int>> count;
        for (int i = 0; i < k; ++i) {
            count[votes[0][i]] = vector<int>(k, 0);
        }
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < k; ++j) {
                count[votes[i][j]][j]++;
            }
        }
        vector<char> chars;
        for (auto& p : count) {
            chars.push_back(p.first);
        }
        sort(chars.begin(), chars.end(), [&](char a, char b) {
            for (int i = 0; i < k; ++i) {
                if (count[a][i] != count[b][i]) {
                    return count[a][i] > count[b][i];
                }
            }
            return a < b;
        });
        string result;
        for (char c : chars) {
            result += c;
        }
        return result;
    }
};