class Solution {
public:
    int addRungs(vector<int>& rungs, int dist) {
        int count = 0;
        int currentHeight = 0;

        for (int rung : rungs) {
            while (currentHeight + dist < rung) {
                currentHeight += dist;
                count++;
            }
            currentHeight = rung;
        }

        return count;
    }
};