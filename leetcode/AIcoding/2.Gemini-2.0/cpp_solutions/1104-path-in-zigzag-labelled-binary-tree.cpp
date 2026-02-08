#include <algorithm>

using namespace std;

class Solution {
public:
    int path[100];

    vector<int> pathInZigZagTree(int label) {
        int level = 1;
        int start = 1;
        while (start * 2 <= label) {
            start *= 2;
            level++;
        }

        int index = level;
        path[index] = label;

        while (index > 1) {
            int prevLevel = index - 1;
            int maxVal = (1 << prevLevel) - 1;
            int minVal = (1 << (prevLevel - 1));

            int parent = path[index] / 2;
            path[prevLevel] = minVal + maxVal - parent;
            index--;
        }

        vector<int> result;
        for (int i = 1; i <= level; i++) {
            result.push_back(path[i]);
        }
        return result;
    }
};