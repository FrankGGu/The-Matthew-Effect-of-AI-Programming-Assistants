class Solution {
public:
    int characterReplacement(string s, int k) {
        vector<int> count(26, 0);
        int left = 0, max_count = 0, max_length = 0;

        for (int right = 0; right < s.size(); ++right) {
            max_count = max(max_count, ++count[s[right] - 'A']);
            while (right - left + 1 - max_count > k) {
                --count[s[left] - 'A'];
                ++left;
            }
            max_length = max(max_length, right - left + 1);
        }

        return max_length;
    }
};