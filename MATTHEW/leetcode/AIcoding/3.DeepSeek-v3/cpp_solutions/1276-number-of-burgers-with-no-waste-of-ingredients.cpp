class Solution {
public:
    vector<int> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        vector<int> res;
        if (tomatoSlices % 2 != 0) return res;
        int total_jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
        int total_small = cheeseSlices - total_jumbo;
        if (total_jumbo >= 0 && total_small >= 0) {
            res.push_back(total_jumbo);
            res.push_back(total_small);
        }
        return res;
    }
};