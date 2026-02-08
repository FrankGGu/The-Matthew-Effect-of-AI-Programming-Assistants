#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isTransformable(string s, string t) {
        vector<vector<int>> posS(10);
        vector<vector<int>> posT(10);

        for (int i = 0; i < s.size(); ++i) {
            posS[s[i] - '0'].push_back(i);
        }
        for (int i = 0; i < t.size(); ++i) {
            posT[t[i] - '0'].push_back(i);
        }

        vector<int> idxS(10, 0);

        for (int i = 0; i < t.size(); ++i) {
            int digit = t[i] - '0';
            if (idxS[digit] >= posS[digit].size()) {
                return false;
            }
            int pos = posS[digit][idxS[digit]];
            for (int j = 0; j < digit; ++j) {
                if (idxS[j] < posS[j].size() && posS[j][idxS[j]] < pos) {
                    return false;
                }
            }
            idxS[digit]++;
        }

        return true;
    }
};