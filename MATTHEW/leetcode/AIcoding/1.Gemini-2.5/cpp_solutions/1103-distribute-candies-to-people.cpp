#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> distributeCandies(int candies, int num_people) {
        std::vector<int> result(num_people, 0);
        int current_candy_amount = 1;
        int person_index = 0;

        while (candies > 0) {
            int give_amount = std::min(current_candy_amount, candies);
            result[person_index] += give_amount;
            candies -= give_amount;
            current_candy_amount++;
            person_index = (person_index + 1) % num_people;
        }

        return result;
    }
};