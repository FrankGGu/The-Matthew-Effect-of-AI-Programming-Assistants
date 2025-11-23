#include <vector>
#include <numeric>

class Solution {
public:
    int maximumPopulation(std::vector<std::vector<int>>& logs) {
        std::vector<int> year_changes(101, 0);

        for (const auto& log : logs) {
            year_changes[log[0] - 1950]++;
            year_changes[log[1] - 1950]--;
        }

        int max_population = 0;
        int result_year = 0;
        int current_population = 0;

        for (int i = 0; i < 101; ++i) {
            current_population += year_changes[i];
            if (current_population > max_population) {
                max_population = current_population;
                result_year = 1950 + i;
            }
        }

        return result_year;
    }
};