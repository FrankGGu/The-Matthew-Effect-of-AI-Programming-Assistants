#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <set>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> invalidTransactions(vector<string>& transactions) {
        vector<string> result;
        unordered_map<string, vector<pair<int, string>>> userTransactions;

        for (int i = 0; i < transactions.size(); ++i) {
            stringstream ss(transactions[i]);
            string name, city;
            int amount, time;
            getline(ss, name, ',');
            ss >> time;
            ss.ignore(1);
            ss >> amount;
            ss.ignore(1);
            getline(ss, city);

            userTransactions[name].push_back({time, city});
        }

        for (int i = 0; i < transactions.size(); ++i) {
            stringstream ss(transactions[i]);
            string name, city;
            int amount, time;
            getline(ss, name, ',');
            ss >> time;
            ss.ignore(1);
            ss >> amount;
            ss.ignore(1);
            getline(ss, city);

            if (amount > 1000) {
                result.push_back(transactions[i]);
                continue;
            }

            bool isInvalid = false;
            for (const auto& [t, c] : userTransactions[name]) {
                if (abs(t - time) > 60 && c != city) {
                    isInvalid = true;
                    break;
                }
            }

            if (isInvalid) {
                result.push_back(transactions[i]);
            }
        }

        return result;
    }
};