#include <vector>
#include <string>
#include <unordered_map>
#include <sstream>
#include <set>

using namespace std;

class Solution {
public:
    vector<string> invalidTransactions(vector<string>& transactions) {
        unordered_map<string, vector<pair<int, int>>> map; // name -> (time, amount)
        vector<string> invalid;

        for (int i = 0; i < transactions.size(); i++) {
            istringstream ss(transactions[i]);
            string name, timeStr, amountStr, city;
            getline(ss, name, ',');
            getline(ss, timeStr, ',');
            getline(ss, amountStr, ',');
            getline(ss, city);
            int time = stoi(timeStr);
            int amount = stoi(amountStr);
            map[name].emplace_back(time, amount);
        }

        set<string> invalidSet;

        for (int i = 0; i < transactions.size(); i++) {
            istringstream ss(transactions[i]);
            string name, timeStr, amountStr, city;
            getline(ss, name, ',');
            getline(ss, timeStr, ',');
            getline(ss, amountStr, ',');
            getline(ss, city);
            int time = stoi(timeStr);
            int amount = stoi(amountStr);

            if (amount > 1000) {
                invalidSet.insert(transactions[i]);
            }

            for (const auto& [otherTime, otherAmount] : map[name]) {
                if (otherTime != time && abs(otherTime - time) <= 60 && city != "New York") {
                    invalidSet.insert(transactions[i]);
                    break;
                }
            }
        }

        for (const auto& str : invalidSet) {
            invalid.push_back(str);
        }

        return invalid;
    }
};