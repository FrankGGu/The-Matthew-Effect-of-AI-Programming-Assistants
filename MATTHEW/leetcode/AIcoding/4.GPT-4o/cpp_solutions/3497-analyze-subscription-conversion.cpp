#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<double> analyzeSubscriptionConversion(vector<string>& data) {
        unordered_map<string, int> total, converted;
        for (const auto& entry : data) {
            auto pos = entry.find(',');
            string month = entry.substr(0, pos);
            string status = entry.substr(pos + 1);
            total[month]++;
            if (status == "converted") {
                converted[month]++;
            }
        }

        vector<double> result;
        for (const auto& month : total) {
            double conversionRate = (converted[month.first] * 100.0) / month.second;
            result.push_back(conversionRate);
        }

        return result;
    }
};