#include <vector>
#include <unordered_map>

using namespace std;

vector<vector<string>> bankAccountSummaryII(vector<vector<string>>& transactions) {
    unordered_map<string, long long> balance;
    for (auto& transaction : transactions) {
        string account = transaction[0];
        long long amount = stoll(transaction[1]);
        balance[account] += amount;
    }

    vector<vector<string>> result;
    for (auto& [account, amount] : balance) {
        if (amount > 10000) {
            result.push_back({account, to_string(amount)});
        }
    }

    return result;
}