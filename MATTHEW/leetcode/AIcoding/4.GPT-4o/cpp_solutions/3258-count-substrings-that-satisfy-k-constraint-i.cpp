class Solution {
public:
    int countSubstrings(string s, int k) {
        int n = s.size();
        vector<int> count(26, 0);
        int res = 0, start = 0, uniqueCount = 0;

        for (int end = 0; end < n; end++) {
            if (++count[s[end] - 'a'] == 1) uniqueCount++;

            while (uniqueCount > k) {
                if (--count[s[start] - 'a'] == 0) uniqueCount--;
                start++;
            }

            res += end - start + 1;
        }

        return res;
    }
};