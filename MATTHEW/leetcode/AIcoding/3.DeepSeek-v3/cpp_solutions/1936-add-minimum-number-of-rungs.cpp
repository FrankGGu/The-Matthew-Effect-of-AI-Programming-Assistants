class Solution {
public:
    int addRungs(vector<int>& rungs, int dist) {
        int res = 0;
        int prev = 0;
        for (int rung : rungs) {
            int diff = rung - prev;
            res += (diff - 1) / dist;
            prev = rung;
        }
        return res;
    }
};