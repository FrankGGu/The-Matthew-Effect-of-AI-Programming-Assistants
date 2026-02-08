class Solution {
public:
    vector<string> invalidTransactions(vector<string>& transactions) {
        unordered_map<string, vector<tuple<int, int, string>>> nameToTrans;
        unordered_set<int> invalidIndices;

        for (int i = 0; i < transactions.size(); ++i) {
            string s = transactions[i];
            size_t pos1 = s.find(',');
            string name = s.substr(0, pos1);
            size_t pos2 = s.find(',', pos1 + 1);
            int time = stoi(s.substr(pos1 + 1, pos2 - pos1 - 1));
            size_t pos3 = s.find(',', pos2 + 1);
            int amount = stoi(s.substr(pos2 + 1, pos3 - pos2 - 1));
            string city = s.substr(pos3 + 1);

            if (amount > 1000) {
                invalidIndices.insert(i);
            }

            for (auto& [t, idx, c] : nameToTrans[name]) {
                if (c != city && abs(t - time) <= 60) {
                    invalidIndices.insert(idx);
                    invalidIndices.insert(i);
                }
            }

            nameToTrans[name].emplace_back(time, i, city);
        }

        vector<string> result;
        for (int idx : invalidIndices) {
            result.push_back(transactions[idx]);
        }
        return result;
    }
};