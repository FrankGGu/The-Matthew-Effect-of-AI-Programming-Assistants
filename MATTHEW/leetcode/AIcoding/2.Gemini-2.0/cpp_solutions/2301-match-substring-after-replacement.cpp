#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool matchReplacement(string s, string sub, vector<vector<string>>& mappings) {
        unordered_map<char, unordered_map<char, bool>> mp;
        for (auto& mapping : mappings) {
            mp[mapping[0][0]][mapping[1][0]] = true;
        }

        for (int i = 0; i <= (int)s.size() - (int)sub.size(); ++i) {
            bool match = true;
            for (int j = 0; j < (int)sub.size(); ++j) {
                if (s[i + j] == sub[j]) continue;
                if (mp.find(sub[j]) != mp.end() && mp[sub[j]].find(s[i + j]) != mp[sub[j]].end()) continue;
                match = false;
                break;
            }
            if (match) return true;
        }

        return false;
    }
};