#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        if (s.size() < p.size()) return {};

        vector<int> pCount(26, 0);
        vector<int> sCount(26, 0);
        vector<int> ans;

        for (int i = 0; i < p.size(); i++) {
            pCount[p[i] - 'a']++;
            sCount[s[i] - 'a']++;
        }

        for (int i = 0; i <= s.size() - p.size(); i++) {
            if (sCount == pCount) {
                ans.push_back(i);
            }
            if (i < s.size() - p.size()) {
                sCount[s[i] - 'a']--;
                sCount[s[i + p.size()] - 'a']++;
            }
        }
        return ans;
    }
};