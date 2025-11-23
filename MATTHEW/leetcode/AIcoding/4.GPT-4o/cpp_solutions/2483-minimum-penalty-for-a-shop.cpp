class Solution {
public:
    int bestClosingTime(string customers) {
        int n = customers.size();
        int penalty = 0;
        for (char c : customers) {
            if (c == 'Y') penalty++;
        }
        int minPenalty = penalty;
        int bestHour = n;

        for (int i = 0; i < n; ++i) {
            if (customers[i] == 'Y') penalty--;
            else penalty++;
            if (penalty < minPenalty) {
                minPenalty = penalty;
                bestHour = i + 1;
            }
        }
        return bestHour;
    }
};