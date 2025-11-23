#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    long long distinctNames(vector<string>& ideas) {
        unordered_set<string> s(ideas.begin(), ideas.end());
        vector<unordered_set<string>> groups(26);

        for (const string& idea : ideas) {
            groups[idea[0] - 'a'].insert(idea.substr(1));
        }

        long long ans = 0;
        for (int i = 0; i < 26; ++i) {
            for (int j = i + 1; j < 26; ++j) {
                int common = 0;
                for (const string& idea : groups[i]) {
                    if (groups[j].count(idea)) {
                        common++;
                    }
                }
                ans += 2LL * (groups[i].size() - common) * (groups[j].size() - common);
            }
        }

        return ans;
    }
};