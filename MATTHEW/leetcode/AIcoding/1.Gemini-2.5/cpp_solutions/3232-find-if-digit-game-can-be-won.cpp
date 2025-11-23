#include <vector>
#include <string>
#include <algorithm>
#include <numeric>

class Solution {
private:
    // Helper function to count the number of digits in an integer
    int countDigits(int n) {
        if (n == 0) {
            return 1;
        }
        int count = 0;
        // For positive integers, repeatedly divide by 10 until it becomes 0
        while (n > 0) {
            n /= 10;
            count++;
        }
        return count;
    }

public:
    bool canTheGameBeWon(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();
        std::vector<long long> effective_values;
        effective_values.reserve(n);

        // Calculate the effective value for each index
        // based on the number of digits in nums1[i]
        for (int i = 0; i < n; ++i) {
            int digits_count = countDigits(nums1[i]);
            if (digits_count % 2 == 0) { // Even number of digits
                effective_values.push_back(nums1[i]);
            } else { // Odd number of digits
                effective_values.push_back(nums2[i]);
            }
        }

        // Sort the effective values in descending order.
        // In a game where players take turns picking items to maximize their score
        // from a fixed set of items, both players will always pick the largest
        // available item.
        std::sort(effective_values.rbegin(), effective_values.rend());

        long long player1_score = 0;
        long long player2_score = 0;

        // Player 1 picks items at indices 0, 2, 4, ... (after sorting)
        // Player 2 picks items at indices 1, 3, 5, ... (after sorting)
        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) { // Player 1's turn
                player1_score += effective_values[i];
            } else { // Player 2's turn
                player2_score += effective_values[i];
            }
        }

        // Return true if Player 1's score is strictly greater than Player 2's score
        return player1_score > player2_score;
    }
};