class Solution {
public:
    vector<string> bankAccountSummary(vector<vector<string>>& accounts) {
        vector<string> result;
        for (const auto& account : accounts) {
            long long balance = stoll(account[1]);
            result.push_back(account[0] + " $" + to_string(balance));
        }
        return result;
    }
};