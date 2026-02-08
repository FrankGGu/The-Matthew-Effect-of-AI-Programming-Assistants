#include <vector>
#include <string>
#include <numeric>
#include <algorithm>
#include <map>

class Solution {
public:
    int countLargestGroup(int n) {
        std::map<int, int> digitSumCounts;

        for (int i = 1; i <= n; ++i) {
            int currentNum = i;
            int sumDigits = 0;
            while (currentNum > 0) {
                sumDigits += currentNum % 10;
                currentNum /= 10;
            }
            digitSumCounts[sumDigits]++;
        }

        int maxGroupSize = 0;
        for (auto const& [sum, count] : digitSumCounts) {
            if (count > maxGroupSize) {
                maxGroupSize = count;
            }
        }

        int numberOfLargestGroups = 0;
        for (auto const& [sum, count] : digitSumCounts) {
            if (count == maxGroupSize) {
                numberOfLargestGroups++;
            }
        }

        return numberOfLargestGroups;
    }
};