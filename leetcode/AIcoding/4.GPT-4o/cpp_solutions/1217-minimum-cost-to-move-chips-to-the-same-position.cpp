class Solution {
public:
    int minCostToMoveChips(vector<int>& chips) {
        int odd = 0, even = 0;
        for (int chip : chips) {
            if (chip % 2 == 0) even++;
            else odd++;
        }
        return min(odd, even);
    }
};