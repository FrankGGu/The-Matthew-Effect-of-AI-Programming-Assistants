#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> spellDamage(vector<string>& skills, vector<vector<int>>& strong, vector<vector<int>>& weak) {
        unordered_map<string, int> skillIndex;
        for (int i = 0; i < skills.size(); ++i) {
            skillIndex[skills[i]] = i;
        }

        vector<int> result(skills.size(), 0);

        for (const auto& s : strong) {
            int idx = skillIndex[s[0]];
            result[idx] += s[1];
        }

        for (const auto& w : weak) {
            int idx = skillIndex[w[0]];
            result[idx] -= w[1];
        }

        return result;
    }
};