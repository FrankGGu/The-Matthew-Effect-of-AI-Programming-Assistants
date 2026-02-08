class Solution {
public:
    string minWindow(string s, string t) {
        unordered_map<char, int> target, window;
        for (char c : t) target[c]++;

        int left = 0, right = 0;
        int required = target.size();
        int formed = 0;
        int min_len = INT_MAX;
        string result = "";

        while (right < s.size()) {
            char c = s[right];
            window[c]++;

            if (target.count(c) && window[c] == target[c]) {
                formed++;
            }

            while (left <= right && formed == required) {
                c = s[left];
                if (right - left + 1 < min_len) {
                    min_len = right - left + 1;
                    result = s.substr(left, min_len);
                }

                window[c]--;
                if (target.count(c) && window[c] < target[c]) {
                    formed--;
                }
                left++;
            }
            right++;
        }

        return result;
    }
};