#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> subscriptionConversion(vector<vector<string>>& users, vector<vector<string>>& sessions, vector<vector<string>>& conversions) {
        map<string, int> userToSessionCount;
        map<string, int> userToConversionCount;

        for (const auto& session : sessions) {
            string userId = session[0];
            userToSessionCount[userId]++;
        }

        for (const auto& conversion : conversions) {
            string userId = conversion[0];
            userToConversionCount[userId]++;
        }

        vector<string> result;
        for (const auto& user : users) {
            string userId = user[0];
            if (userToSessionCount.find(userId) != userToSessionCount.end() && userToConversionCount.find(userId) != userToConversionCount.end()) {
                int sessions = userToSessionCount[userId];
                int conversions = userToConversionCount[userId];
                if (conversions > 0 && sessions > 0) {
                    double conversionRate = static_cast<double>(conversions) / sessions;
                    result.push_back(userId + " " + to_string(conversionRate));
                }
            }
        }

        return result;
    }
};