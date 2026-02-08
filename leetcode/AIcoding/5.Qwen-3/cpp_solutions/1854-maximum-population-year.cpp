#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int maximumPopulation(vector<vector<int>>& logs) {
        map<int, int> delta;
        for (const auto& log : logs) {
            delta[log[0]]++;
            delta[log[1]]--;
        }

        int maxPopulation = 0;
        int currentPopulation = 0;
        int resultYear = 0;

        for (const auto& [year, change] : delta) {
            currentPopulation += change;
            if (currentPopulation > maxPopulation) {
                maxPopulation = currentPopulation;
                resultYear = year;
            }
        }

        return resultYear;
    }
};