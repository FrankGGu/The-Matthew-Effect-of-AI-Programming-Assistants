class Solution {
public:
    int getWinner(vector<int>& arr, int k) {
        int winner = arr[0];
        int wins = 0;
        for (int i = 1; i < arr.size(); ++i) {
            if (winner > arr[i]) {
                wins++;
            } else {
                winner = arr[i];
                wins = 1;
            }
            if (wins == k) {
                return winner;
            }
        }
        return winner;
    }
};