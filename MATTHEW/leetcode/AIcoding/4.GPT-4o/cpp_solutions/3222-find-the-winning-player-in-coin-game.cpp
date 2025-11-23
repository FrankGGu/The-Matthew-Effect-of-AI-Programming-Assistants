class Solution {
public:
    string findTheWinner(int n, int k) {
        int winner = 0;
        for (int i = 1; i <= n; ++i) {
            winner = (winner + k) % i;
        }
        return to_string(winner + 1);
    }
};