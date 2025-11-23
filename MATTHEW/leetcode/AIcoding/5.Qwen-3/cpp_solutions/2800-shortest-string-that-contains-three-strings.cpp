#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string minimumString(string a, string b, string c) {
        vector<string> candidates;
        vector<vector<string>> permutations = {
            {a, b, c},
            {a, c, b},
            {b, a, c},
            {b, c, a},
            {c, a, b},
            {c, b, a}
        };

        for (const auto& perm : permutations) {
            string combined = perm[0];
            for (int i = 1; i < 3; ++i) {
                int pos = 0;
                while (pos <= combined.size() && combined.find(perm[i], pos) != 0) {
                    ++pos;
                }
                if (pos == combined.size()) {
                    combined += perm[i];
                } else {
                    combined = combined.substr(0, pos) + perm[i];
                }
            }
            candidates.push_back(combined);
        }

        sort(candidates.begin(), candidates.end(), [](const string& a, const string& b) {
            return a.size() < b.size() || (a.size() == b.size() && a < b);
        });

        return candidates[0];
    }
};