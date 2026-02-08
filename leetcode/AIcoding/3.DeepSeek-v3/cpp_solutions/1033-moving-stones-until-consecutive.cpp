class Solution {
public:
    vector<int> numMovesStones(int a, int b, int c) {
        vector<int> stones = {a, b, c};
        sort(stones.begin(), stones.end());
        int min_moves, max_moves;

        if (stones[2] - stones[0] == 2) {
            min_moves = 0;
        } else if (stones[1] - stones[0] <= 2 || stones[2] - stones[1] <= 2) {
            min_moves = 1;
        } else {
            min_moves = 2;
        }

        max_moves = stones[2] - stones[0] - 2;

        return {min_moves, max_moves};
    }
};