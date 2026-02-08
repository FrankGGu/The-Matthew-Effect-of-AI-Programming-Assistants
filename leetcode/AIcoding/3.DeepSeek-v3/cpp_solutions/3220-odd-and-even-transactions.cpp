#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> invalidTransactions(vector<string>& transactions) {
        unordered_map<string, vector<tuple<int, int, string>>> nameToTrans;
        vector<string> result;

        for (const string& t : transactions) {
            size_t pos1 = t.find(',');
            string name = t.substr(0, pos1);
            size_t pos2 = t.find(',', pos1 + 1);
            int time = stoi(t.substr(pos1 + 1, pos2 - pos1 - 1));
            size_t pos3 = t.find(',', pos2 + 1);
            int amount = stoi(t.substr(pos2 + 1, pos3 - pos2 - 1));
            string city = t.substr(pos3 + 1);

            nameToTrans[name].emplace_back(time, amount, city);
        }

        for (const auto& entry : nameToTrans) {
            const string& name = entry.first;
            const vector<tuple<int, int, string>>& trans = entry.second;

            for (size_t i = 0; i < trans.size(); ++i) {
                const auto& [time, amount, city] = trans[i];
                bool invalid = false;

                if (amount > 1000) {
                    invalid = true;
                }

                for (size_t j = 0; j < trans.size(); ++j) {
                    if (i == j) continue;
                    const auto& [otherTime, otherAmount, otherCity] = trans[j];
                    if (abs(time - otherTime) <= 60 && city != otherCity) {
                        invalid = true;
                        break;
                    }
                }

                if (invalid) {
                    string transaction = name + "," + to_string(time) + "," + 
                                       to_string(amount) + "," + city;
                    result.push_back(transaction);
                }
            }
        }

        return result;
    }
};