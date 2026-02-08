#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> findEvenNumbers(std::vector<int>& digits) {
        std::vector<int> counts(10, 0);
        for (int digit : digits) {
            counts[digit]++;
        }

        std::vector<int> result;
        for (int num = 100; num <= 999; ++num) {
            if (num % 2 != 0) { // Number must be even
                continue;
            }

            int c = num % 10;
            int b = (num / 10) % 10;
            int a = num / 100;

            std::vector<int> temp_counts = counts; // Use a temporary copy for each number check

            bool possible = true;

            // Check and decrement count for the first digit 'a'
            if (temp_counts[a] > 0) {
                temp_counts[a]--;
            } else {
                possible = false;
            }

            // Check and decrement count for the second digit 'b'
            if (possible && temp_counts[b] > 0) {
                temp_counts[b]--;
            } else {
                possible = false;
            }

            // Check and decrement count for the third digit 'c'
            if (possible && temp_counts[c] > 0) {
                temp_counts[c]--;
            } else {
                possible = false;
            }

            if (possible) {
                result.push_back(num);
            }
        }

        return result;
    }
};