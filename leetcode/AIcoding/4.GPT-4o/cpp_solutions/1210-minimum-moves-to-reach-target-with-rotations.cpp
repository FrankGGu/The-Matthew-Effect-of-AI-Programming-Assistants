class Solution {
public:
    int minimumMoves(vector<int>& start, vector<int>& target) {
        int x_diff = abs(start[0] - target[0]);
        int y_diff = abs(start[1] - target[1]);
        return (x_diff + y_diff + 2) / 3;
    }
};