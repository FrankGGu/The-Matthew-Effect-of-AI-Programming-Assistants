#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    int digArtifacts(int n, vector<vector<int>>& artifacts, vector<vector<int>>& dig) {
        set<pair<int, int>> dug;
        for (auto& d : dig) {
            dug.insert({d[0], d[1]});
        }

        int count = 0;
        for (auto& artifact : artifacts) {
            bool extracted = true;
            for (int i = artifact[0]; i <= artifact[2]; ++i) {
                for (int j = artifact[1]; j <= artifact[3]; ++j) {
                    if (dug.find({i, j}) == dug.end()) {
                        extracted = false;
                        break;
                    }
                }
                if (!extracted) break;
            }
            if (extracted) count++;
        }

        return count;
    }
};