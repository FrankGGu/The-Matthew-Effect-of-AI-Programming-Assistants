#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<long long> getDistances(int n, vector<vector<int>>& pieces) {
        vector<long long> ans(n);
        vector<vector<int>> pos(pieces.size());
        for (int i = 0; i < pieces.size(); ++i) {
            for (int j = 0; j < pieces[i].size(); ++j) {
                pos[i].push_back(j);
            }
        }

        vector<int> perm(pieces.size());
        iota(perm.begin(), perm.end(), 0);

        do {
            long long dist = 0;
            for (int i = 0; i < pieces.size() - 1; ++i) {
                int idx1 = perm[i];
                int idx2 = perm[i + 1];
                dist += abs((int)pos[idx1].size() - (int)pos[idx2].size());
            }
            ans[perm[0]] += dist;
        } while (next_permutation(perm.begin(), perm.end()));

        return ans;
    }
};