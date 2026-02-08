class Solution {
public:
    int bestClosingTime(string customers) {
        int n = customers.size();
        int min_penalty = 0;
        int current_penalty = 0;
        int best_hour = 0;

        for (int i = 0; i < n; ++i) {
            if (customers[i] == 'Y') {
                current_penalty--;
            } else {
                current_penalty++;
            }
            if (current_penalty < min_penalty) {
                min_penalty = current_penalty;
                best_hour = i + 1;
            }
        }

        return best_hour;
    }
};