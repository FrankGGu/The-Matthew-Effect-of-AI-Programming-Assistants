class Solution {
public:
    int stoneGameVI(vector<int>& A, vector<int>& B) {
        vector<pair<int, int>> value;
        for (int i = 0; i < A.size(); ++i) {
            value.push_back({A[i] + B[i], i});
        }
        sort(value.rbegin(), value.rend());
        int alexScore = 0, leeScore = 0;
        for (int i = 0; i < value.size(); ++i) {
            if (i % 2 == 0) {
                alexScore += A[value[i].second];
            } else {
                leeScore += B[value[i].second];
            }
        }
        if (alexScore > leeScore) return 1;
        if (alexScore < leeScore) return -1;
        return 0;
    }
};