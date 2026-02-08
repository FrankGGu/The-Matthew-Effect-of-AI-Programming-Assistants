class Solution {
public:
    string shortestPalindrome(string s) {
        string rev_s = s;
        reverse(rev_s.begin(), rev_s.end());
        string l = s + "#" + rev_s;
        int n = l.size();
        vector<int> pi(n, 0);

        for (int i = 1; i < n; i++) {
            int j = pi[i - 1];
            while (j > 0 && l[i] != l[j]) {
                j = pi[j - 1];
            }
            if (l[i] == l[j]) {
                j++;
            }
            pi[i] = j;
        }

        return rev_s.substr(0, s.size() - pi[n - 1]) + s;
    }
};