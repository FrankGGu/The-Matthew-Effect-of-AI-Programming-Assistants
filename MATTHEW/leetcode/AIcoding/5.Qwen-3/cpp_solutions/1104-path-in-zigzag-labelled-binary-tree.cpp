#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> pathInZigzagTree(int label) {
        vector<int> path;
        int level = 0;
        while (pow(2, level) <= label) {
            level++;
        }
        level--;

        while (label > 0) {
            path.push_back(label);
            int prevLevel = level - 1;
            int first = pow(2, prevLevel);
            int last = pow(2, prevLevel + 1) - 1;
            int mirrored = first + last - label;
            label = mirrored / 2;
            level--;
        }

        reverse(path.begin(), path.end());
        return path;
    }
};