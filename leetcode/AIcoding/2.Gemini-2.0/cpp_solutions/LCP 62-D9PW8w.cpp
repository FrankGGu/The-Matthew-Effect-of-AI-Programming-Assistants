#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int transportationHub(vector<vector<int>>& paths) {
        int n = 0;
        for (const auto& path : paths) {
            n = max(n, max(path[0], path[1]));
        }
        n++;

        vector<int> inDegree(n, 0);
        vector<int> outDegree(n, 0);

        for (const auto& path : paths) {
            outDegree[path[0]]++;
            inDegree[path[1]]++;
        }

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == n - 1 && outDegree[i] == 0) {
                bool valid = true;
                for (int j = 0; j < n; ++j) {
                    if (i != j) {
                        bool found = false;
                        for (const auto& path : paths) {
                            if (path[0] == j && path[1] == i) {
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            valid = false;
                            break;
                        }
                    }
                }
                if (valid) return i;
            }
        }

        return -1;
    }
};