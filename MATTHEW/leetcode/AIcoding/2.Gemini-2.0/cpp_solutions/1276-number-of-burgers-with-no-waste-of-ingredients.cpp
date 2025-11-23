class Solution {
public:
    vector<int> solve(int tomatoSlices, int cheeseSlices) {
        int jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
        int small = cheeseSlices - jumbo;

        if (jumbo < 0 || small < 0 || jumbo * 4 + small * 2 != tomatoSlices || jumbo + small != cheeseSlices) {
            return {};
        }

        return {jumbo, small};
    }

    vector<int> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        return solve(tomatoSlices, cheeseSlices);
    }
};