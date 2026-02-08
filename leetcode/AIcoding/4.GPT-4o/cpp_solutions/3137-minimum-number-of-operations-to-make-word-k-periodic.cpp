class Solution {
public:
    int minOperations(string s, int k) {
        int n = s.size();
        int res = 0;

        for (int i = 0; i < k; ++i) {
            vector<int> count(26, 0);
            for (int j = i; j < n; j += k) {
                count[s[j] - 'a']++;
            }
            int max_freq = *max_element(count.begin(), count.end());
            res += (n / k) - max_freq;
        }

        return res;
    }
};