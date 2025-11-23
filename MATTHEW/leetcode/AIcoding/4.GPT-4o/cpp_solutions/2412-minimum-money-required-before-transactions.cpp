class Solution {
public:
    long long minimumMoney(vector<vector<int>>& transactions) {
        long long total = 0, need = 0;
        for (const auto& t : transactions) {
            total += t[1];
            if (t[0] > t[1]) {
                need += t[0] - t[1];
            }
        }
        return total + need;
    }
};