class Solution {
public:
    vector<int> mostBeautifulItem(vector<int>& items, vector<int>& queries) {
        int n = items.size();
        vector<int> results;
        vector<pair<int, int>> sorted_items(n);

        for (int i = 0; i < n; ++i) {
            sorted_items[i] = {items[i], i};
        }

        sort(sorted_items.begin(), sorted_items.end());

        for (int q : queries) {
            int max_beauty = -1;
            for (auto& [beauty, index] : sorted_items) {
                if (index <= q) {
                    max_beauty = max(max_beauty, beauty);
                } else {
                    break;
                }
            }
            results.push_back(max_beauty);
        }

        return results;
    }
};