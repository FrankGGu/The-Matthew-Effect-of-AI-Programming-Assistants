class Solution {
public:
    int beautifulArray(int N) {
        vector<int> ans(N);
        iota(ans.begin(), ans.end(), 1);
        for (int i = 1; i < N; i *= 2) {
            for (int j = 0; j < i && j + i < N; j++) {
                swap(ans[j], ans[j + i]);
            }
        }
        return ans;
    }
};