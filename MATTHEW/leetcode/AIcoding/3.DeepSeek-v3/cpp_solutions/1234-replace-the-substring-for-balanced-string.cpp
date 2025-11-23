class Solution {
public:
    int balancedString(string s) {
        unordered_map<char, int> count;
        int n = s.size();
        int res = n;
        int left = 0;
        int k = n / 4;

        for (char c : s) {
            count[c]++;
        }

        for (int right = 0; right < n; ++right) {
            count[s[right]]--;
            while (left < n && count['Q'] <= k && count['W'] <= k && count['E'] <= k && count['R'] <= k) {
                res = min(res, right - left + 1);
                count[s[left]]++;
                left++;
            }
        }

        return res;
    }
};