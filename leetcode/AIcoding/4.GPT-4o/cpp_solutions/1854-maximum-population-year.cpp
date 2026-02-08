class Solution {
public:
    int maximumPopulation(vector<vector<int>>& logs) {
        vector<int> populationChange(2050, 0);
        for (const auto& log : logs) {
            populationChange[log[0]]++;
            populationChange[log[1]]--;
        }
        int maxPopulation = 0, year = 1950;
        int currentPopulation = 0;
        for (int i = 1950; i <= 2050; ++i) {
            currentPopulation += populationChange[i];
            if (currentPopulation > maxPopulation) {
                maxPopulation = currentPopulation;
                year = i;
            }
        }
        return year;
    }
};