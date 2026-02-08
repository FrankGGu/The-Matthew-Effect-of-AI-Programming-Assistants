class Solution {
public:
    vector<int> pathInZigZagTree(int label) {
        vector<int> res;
        int level = 0;
        while (1 << level <= label) {
            level++;
        }
        while (label >= 1) {
            res.push_back(label);
            int level_start = 1 << (level - 1);
            int level_end = (1 << level) - 1;
            int parent = (level_start + level_end - label) / 2;
            label = parent;
            level--;
        }
        reverse(res.begin(), res.end());
        return res;
    }
};