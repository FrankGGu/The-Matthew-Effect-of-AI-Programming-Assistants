class Solution {
public:
    int getWinner(vector<int>& arr, int k) {
        int winner = arr[0];
        int winCount = 0;
        int n = arr.size();

        if (k >= n - 1) {
            return *max_element(arr.begin(), arr.end());
        }

        for (int i = 1; i < n; ++i) {
            if (winner > arr[i]) {
                winCount++;
            } else {
                winner = arr[i];
                winCount = 1;
            }

            if (winCount == k) {
                return winner;
            }
        }

        return winner;
    }
};