class Solution {
public:
    int findWinningPlayer(vector<int>& skills, int k) {
        int n = skills.size();
        if (k >= n - 1) {
            return max_element(skills.begin(), skills.end()) - skills.begin();
        }

        int current_winner = 0;
        int consecutive_wins = 0;

        for (int i = 1; i < n; ++i) {
            if (skills[current_winner] > skills[i]) {
                consecutive_wins++;
            } else {
                current_winner = i;
                consecutive_wins = 1;
            }

            if (consecutive_wins == k) {
                return current_winner;
            }
        }

        return current_winner;
    }
};