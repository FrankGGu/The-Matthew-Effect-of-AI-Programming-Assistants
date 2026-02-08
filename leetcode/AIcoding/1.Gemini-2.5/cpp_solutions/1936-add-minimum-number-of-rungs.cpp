class Solution {
public:
    int addRungs(std::vector<int>& rungs, int dist) {
        int addedRungs = 0;
        long long currentHeight = 0;

        for (int rung : rungs) {
            long long gap = rung - currentHeight;
            if (gap > dist) {
                addedRungs += (gap - 1) / dist;
            }
            currentHeight = rung;
        }

        return addedRungs;
    }
};