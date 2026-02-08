#include <vector>
#include <cmath>
using namespace std;

class Solution {
public:
    vector<int> pathInZigZagTree(int label) {
        vector<int> path;
        int level = log2(label);
        while (level >= 0) {
            path.push_back(label);
            label = (1 << level) - label / 2 - 1;
            level--;
        }
        reverse(path.begin(), path.end());
        return path;
    }
};