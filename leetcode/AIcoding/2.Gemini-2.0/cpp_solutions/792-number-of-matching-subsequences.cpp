#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int numMatchingSubsequences(string s, vector<string>& words) {
        int count = 0;
        vector<vector<int>> pos(26);
        for (int i = 0; i < s.size(); ++i) {
            pos[s[i] - 'a'].push_back(i);
        }

        for (const string& word : words) {
            int prev = -1;
            bool match = true;
            for (char c : word) {
                auto& v = pos[c - 'a'];
                auto it = upper_bound(v.begin(), v.end(), prev);
                if (it == v.end()) {
                    match = false;
                    break;
                }
                prev = *it;
            }
            if (match) {
                count++;
            }
        }

        return count;
    }
};