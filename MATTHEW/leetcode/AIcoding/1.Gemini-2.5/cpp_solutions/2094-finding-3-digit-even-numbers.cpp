#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> findEvenNumbers(std::vector<int>& digits) {
        std::vector<int> counts(10, 0);
        for (int digit : digits) {
            counts[digit]++;
        }

        std::vector<int> result;

        for (int num = 100; num <= 998; num += 2) {
            int d1 = num / 100;
            int d2 = (num / 10) % 10;
            int d3 = num % 10;

            std::vector<int> temp_counts = counts;

            temp_counts[d1]--;
            temp_counts[d2]--;
            temp_counts[d3]--;

            if (temp_counts[d1] >= 0 && temp_counts[d2] >= 0 && temp_counts[d3] >= 0) {
                result.push_back(num);
            }
        }

        return result;
    }
};