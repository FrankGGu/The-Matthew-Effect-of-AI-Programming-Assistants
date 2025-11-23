#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<bool> canEat(std::vector<int>& candiesCount, std::vector<std::vector<int>>& queries) {
        int n = candiesCount.size();
        std::vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + candiesCount[i];
        }

        std::vector<bool> result;
        result.reserve(queries.size());

        for (const auto& query : queries) {
            int candyType = query[0];
            int day = query[1];
            int dailyCap = query[2];

            long long daysPassed = day + 1;

            // Minimum total candies eaten by the end of 'day' (inclusive)
            // We eat at least 1 candy per day.
            long long minPossibleEaten = daysPassed * 1;

            // Maximum total candies eaten by the end of 'day' (inclusive)
            // We eat at most 'dailyCap' candies per day.
            long long maxPossibleEaten = daysPassed * dailyCap;

            // Minimum total candies that must be eaten to reach 'candyType' and eat it on 'day'
            // This means consuming all candies of types 0 to candyType-1, plus at least 1 of candyType itself.
            long long minRequiredToEatCandyType = prefixSum[candyType] + 1;

            // Maximum total candies that can be eaten while still being on 'candyType' on 'day'
            // This means we must not have consumed all candies of 'candyType' and moved to the next type.
            // So, total candies eaten must be at most (all candies up to candyType-1) + (all candies of candyType).
            long long maxAllowedToEatCandyType = prefixSum[candyType + 1];

            bool possible = (maxPossibleEaten >= minRequiredToEatCandyType) && 
                            (minPossibleEaten <= maxAllowedToEatCandyType);

            result.push_back(possible);
        }

        return result;
    }
};