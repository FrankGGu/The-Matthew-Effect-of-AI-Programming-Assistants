#include <vector>
#include <sstream>
#include <algorithm>

using namespace std;

struct Transaction {
    string name;
    int time;
    int amount;
    string city;
    int index;
};

vector<string> invalidTransactions(vector<string>& transactions) {
    vector<Transaction> trans;
    int n = transactions.size();

    for (int i = 0; i < n; ++i) {
        stringstream ss(transactions[i]);
        string token;
        vector<string> tokens;
        while (getline(ss, token, ',')) {
            tokens.push_back(token);
        }

        Transaction t;
        t.name = tokens[0];
        t.time = stoi(tokens[1]);
        t.amount = stoi(tokens[2]);
        t.city = tokens[3];
        t.index = i;
        trans.push_back(t);
    }

    vector<string> res;
    vector<bool> invalid(n, false);

    for (int i = 0; i < n; ++i) {
        if (trans[i].amount > 1000) {
            invalid[i] = true;
        }
        for (int j = i + 1; j < n; ++j) {
            if (trans[i].name == trans[j].name && trans[i].city != trans[j].city && abs(trans[i].time - trans[j].time) <= 60) {
                invalid[i] = true;
                invalid[j] = true;
            }
        }
    }

    for (int i = 0; i < n; ++i) {
        if (invalid[i]) {
            res.push_back(transactions[i]);
        }
    }

    return res;
}