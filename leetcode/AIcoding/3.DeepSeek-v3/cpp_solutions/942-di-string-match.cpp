class Solution {
public:
    vector<int> diStringMatch(string S) {
        int n = S.size();
        vector<int> res(n + 1);
        int low = 0, high = n;
        for (int i = 0; i < n; ++i) {
            if (S[i] == 'I') {
                res[i] = low++;
            } else {
                res[i] = high--;
            }
        }
        res[n] = low;
        return res;
    }
};