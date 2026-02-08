class Solution {
public:
    int uniqueLetterString(string s) {
        int n = s.size();
        vector<int> last(128, -1);
        long long result = 0;
        int mod = 1e9 + 7;

        for (int i = 0; i < n; ++i) {
            int count = i - last[s[i]]; 
            result = (result + count * (i + 1)) % mod;
            last[s[i]] = i;
        }

        return result;
    }
};