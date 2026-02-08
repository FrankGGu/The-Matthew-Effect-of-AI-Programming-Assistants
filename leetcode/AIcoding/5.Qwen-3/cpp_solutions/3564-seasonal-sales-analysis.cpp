#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> seasonalSalesAnalysis(vector<vector<string>>& sales) {
        map<string, int> seasonMap;
        map<string, int> monthMap;
        map<string, int> productMap;

        for (const auto& sale : sales) {
            string season = sale[0];
            string month = sale[1];
            string product = sale[2];

            seasonMap[season]++;
            monthMap[month]++;
            productMap[product]++;
        }

        vector<vector<string>> result;

        for (const auto& pair : seasonMap) {
            result.push_back({pair.first, to_string(pair.second)});
        }

        for (const auto& pair : monthMap) {
            result.push_back({pair.first, to_string(pair.second)});
        }

        for (const auto& pair : productMap) {
            result.push_back({pair.first, to_string(pair.second)});
        }

        sort(result.begin(), result.end());

        return result;
    }
};