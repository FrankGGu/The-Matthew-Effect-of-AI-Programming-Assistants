#include <vector>
#include <string>
#include <map>

struct User {
    int account;
    std::string name;
};

struct Transaction {
    int trans_id;
    int account;
    int amount;
    std::string trans_date;
};

class Solution {
public:
    std::vector<std::string> bankAccountSummaryII(std::vector<User>& users, std::vector<Transaction>& transactions) {
        std::map<int, long long> account_balances;
        for (const auto& trans : transactions) {
            account_balances[trans.account] += trans.amount;
        }

        std::map<int, std::string> account_to_name_map;
        for (const auto& user : users) {
            account_to_name_map[user.account] = user.name;
        }

        std::vector<std::string> result_names;
        for (const auto& entry : account_balances) {
            int account_id = entry.first;
            long long total_balance = entry.second;

            if (total_balance > 10000) {
                if (account_to_name_map.count(account_id)) {
                    result_names.push_back(account_to_name_map[account_id]);
                }
            }
        }

        return result_names;
    }
};