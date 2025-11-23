class Solution {
public:
    int maximumPopulation(vector<vector<int>>& logs) {
        vector<int> population(101, 0); // 1950 to 2050

        for (const auto& log : logs) {
            int birth = log[0] - 1950;
            int death = log[1] - 1950;
            for (int year = birth; year < death; ++year) {
                population[year]++;
            }
        }

        int max_pop = 0;
        int max_year = 0;
        for (int year = 0; year <= 100; ++year) {
            if (population[year] > max_pop) {
                max_pop = population[year];
                max_year = year;
            }
        }

        return max_year + 1950;
    }
};