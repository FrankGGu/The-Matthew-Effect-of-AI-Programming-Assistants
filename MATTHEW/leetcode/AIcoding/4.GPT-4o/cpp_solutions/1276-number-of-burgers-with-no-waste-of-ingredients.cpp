class Solution {
public:
    vector<int> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        if (tomatoSlices % 2 != 0 || tomatoSlices > 4 * cheeseSlices || tomatoSlices < 2 * cheeseSlices) {
            return {};
        }
        int jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
        int small = cheeseSlices - jumbo;
        return {jumbo, small};
    }
};