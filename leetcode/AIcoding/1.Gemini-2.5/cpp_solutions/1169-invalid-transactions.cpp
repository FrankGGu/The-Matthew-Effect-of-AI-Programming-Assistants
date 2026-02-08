#include <vector>
#include <string>
#include <sstream>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<string> invalidTransactions(vector<string>& transactions) {
        int n = transactions.size();
        if (n == 0) {
            return {};
        }

        struct TransactionData {
            string name;
            int time;
            int amount;
            string city;
        };

        vector<TransactionData> data(n);
        for (int i = 0; i < n; ++i) {
            stringstream ss(transactions[i]);
            string temp;
            getline(ss, data[i].name, ',');
            getline(ss, temp, ',');
            data[i].time = stoi(temp);
            getline(ss, temp, ',');
            data[i].amount = stoi(temp);
            getline(ss, data[i].city, ',');
        }

        vector<bool> is_invalid(n, false);

        for (int i = 0; i < n; ++i) {
            if (data[i].amount > 1000) {
                is_invalid[i] = true;
            }
            for (int j = i + 1; j < n; ++j) {
                if (data[i].name == data[j].name &&
                    data[i].city != data[j].city &&
                    abs(data[i].time - data[j].time) <= 60) {
                    is_invalid[i] = true;
                    is_invalid[j] = true;
                }
            }
        }

        vector<string> result;
        for (int i = 0; i < n; ++i) {
            if (is_invalid[i]) {
                result.push_back(transactions[i]);
            }
        }
        return result;
    }
};