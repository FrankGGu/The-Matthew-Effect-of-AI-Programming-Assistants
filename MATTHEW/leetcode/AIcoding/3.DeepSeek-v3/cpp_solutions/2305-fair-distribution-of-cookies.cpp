class Solution {
public:
    int distributeCookies(vector<int>& cookies, int k) {
        int n = cookies.size();
        vector<int> distribution(k, 0);
        return backtrack(0, distribution, cookies, k);
    }

private:
    int backtrack(int idx, vector<int>& distribution, vector<int>& cookies, int k) {
        if (idx == cookies.size()) {
            return *max_element(distribution.begin(), distribution.end());
        }
        int res = INT_MAX;
        for (int i = 0; i < k; ++i) {
            distribution[i] += cookies[idx];
            res = min(res, backtrack(idx + 1, distribution, cookies, k));
            distribution[i] -= cookies[idx];
        }
        return res;
    }
};