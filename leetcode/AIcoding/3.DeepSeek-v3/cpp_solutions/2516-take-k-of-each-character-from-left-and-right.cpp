class Solution {
public:
    int takeCharacters(string s, int k) {
        int n = s.size();
        vector<int> count(3, 0);
        for (char c : s) {
            count[c - 'a']++;
        }
        if (count[0] < k || count[1] < k || count[2] < k) {
            return -1;
        }

        int left = 0;
        int res = n;
        for (int right = 0; right < n; right++) {
            count[s[right] - 'a']--;
            while (count[s[right] - 'a'] < k) {
                count[s[left] - 'a']++;
                left++;
            }
            res = min(res, n - (right - left + 1));
        }
        return res;
    }
};