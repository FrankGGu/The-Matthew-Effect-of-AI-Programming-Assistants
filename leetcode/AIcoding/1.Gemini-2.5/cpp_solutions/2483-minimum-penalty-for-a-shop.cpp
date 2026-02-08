#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int bestClosingTime(std::string customers) {
        int n = customers.length();
        int min_penalty = 0;
        int current_penalty = 0;
        int min_hour = 0;

        for (int i = 0; i < n; ++i) {
            if (customers[i] == 'Y') {
                current_penalty++;
            }
        }
        min_penalty = current_penalty;

        for (int j = 1; j <= n; ++j) {
            if (customers[j - 1] == 'Y') {
                current_penalty--;
            } else { // customers[j-1] == 'N'
                current_penalty++;
            }

            if (current_penalty < min_penalty) {
                min_penalty = current_penalty;
                min_hour = j;
            }
        }

        return min_hour;
    }
};