class Solution {
public:
    vector<int> beautifulArray(int N) {
        vector<int> ans;
        if (N == 1) return {1};
        for (int i = 1; i <= N; i++) {
            if ((i % 2) == 1) ans.push_back(i);
        }
        for (int i = 1; i <= N; i++) {
            if ((i % 2) == 0) ans.push_back(i);
        }
        return ans;
    }
};