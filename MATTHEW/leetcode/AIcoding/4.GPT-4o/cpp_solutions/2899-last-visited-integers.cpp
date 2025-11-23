class Solution {
public:
    vector<int> findLastVisited(int n, vector<int>& visits) {
        vector<int> lastVisited(n + 1, -1);
        for (int i = 0; i < visits.size(); ++i) {
            lastVisited[visits[i]] = i;
        }
        vector<int> result;
        for (int i = 1; i <= n; ++i) {
            result.push_back(lastVisited[i]);
        }
        return result;
    }
};