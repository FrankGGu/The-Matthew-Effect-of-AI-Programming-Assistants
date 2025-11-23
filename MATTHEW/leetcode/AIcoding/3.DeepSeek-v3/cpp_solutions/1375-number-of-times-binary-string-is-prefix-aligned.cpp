class Solution {
public:
    int numTimesAllBlue(vector<int>& flips) {
        int max_pos = 0;
        int res = 0;
        for (int i = 0; i < flips.size(); ++i) {
            max_pos = max(max_pos, flips[i]);
            if (max_pos == i + 1) {
                res++;
            }
        }
        return res;
    }
};