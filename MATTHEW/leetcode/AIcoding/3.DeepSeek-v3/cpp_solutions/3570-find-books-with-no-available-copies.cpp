class Solution {
public:
    vector<int> findNoAvailableCopies(vector<vector<int>>& books) {
        unordered_set<int> available;
        for (auto& book : books) {
            if (book[1] > 0) {
                available.insert(book[0]);
            }
        }
        vector<int> result;
        for (auto& book : books) {
            if (available.find(book[0]) == available.end()) {
                result.push_back(book[0]);
            }
        }
        sort(result.begin(), result.end());
        result.erase(unique(result.begin(), result.end()), result.end());
        return result;
    }
};