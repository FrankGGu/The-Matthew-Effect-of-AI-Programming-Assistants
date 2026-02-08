class Solution {
public:
    vector<int> platesBetweenCandles(string s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<int> left(n), right(n), prefixSum(n + 1);

        for (int i = 0, j = 0; i < n; i++) {
            if (s[i] == '|') {
                j = i;
            }
            left[i] = j;
        }

        for (int i = n - 1, j = n; i >= 0; i--) {
            if (s[i] == '|') {
                j = i;
            }
            right[i] = j;
        }

        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + (s[i] == '*' ? 1 : 0);
        }

        vector<int> result;
        for (const auto& query : queries) {
            int leftIdx = right[query[0]];
            int rightIdx = left[query[1]];
            if (leftIdx < rightIdx) {
                result.push_back(prefixSum[rightIdx + 1] - prefixSum[leftIdx]);
            } else {
                result.push_back(0);
            }
        }

        return result;
    }
};