class Solution {
public:
    int numTimesAllBlue(vector<int>& flips) {
        int maxIndex = 0, count = 0;
        for (int i = 0; i < flips.size(); i++) {
            maxIndex = max(maxIndex, flips[i]);
            if (maxIndex == i + 1) {
                count++;
            }
        }
        return count;
    }
};