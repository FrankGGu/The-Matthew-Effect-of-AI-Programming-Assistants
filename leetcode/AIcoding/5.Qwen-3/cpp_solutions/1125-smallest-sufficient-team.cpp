#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> smallestSufficientTeam(vector<string>& need, vector<string>& people) {
        unordered_map<string, int> skillToIndex;
        for (int i = 0; i < need.size(); ++i) {
            skillToIndex[need[i]] = i;
        }

        int n = need.size();
        int target = (1 << n) - 1;

        unordered_map<int, vector<int>> dp;
        dp[0] = {};

        for (int i = 0; i < people.size(); ++i) {
            string person = people[i];
            int mask = 0;
            for (char c : person) {
                if (skillToIndex.count(string(1, c))) {
                    mask |= 1 << skillToIndex[string(1, c)];
                }
            }
            if (mask == 0) continue;

            for (auto it = dp.begin(); it != dp.end(); ++it) {
                int prevMask = it->first;
                vector<int> prevList = it->second;
                int newMask = prevMask | mask;
                if (newMask == prevMask) continue;
                vector<int> newList = prevList;
                newList.push_back(i);
                if (dp.find(newMask) == dp.end() || newList.size() < dp[newMask].size()) {
                    dp[newMask] = newList;
                }
            }
        }

        return dp[target];
    }
};