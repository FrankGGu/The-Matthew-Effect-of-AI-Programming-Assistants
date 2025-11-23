class Solution {
public:
    string shortestBeautifulSubstring(string s, int k) {
        int n = s.size();
        int left = 0;
        int count = 0;
        string result = "";

        for (int right = 0; right < n; ++right) {
            if (s[right] == '1') {
                count++;
            }

            while (count == k) {
                string current = s.substr(left, right - left + 1);
                if (result.empty() || current.size() < result.size()) {
                    result = current;
                } else if (current.size() == result.size() && current < result) {
                    result = current;
                }

                if (s[left] == '1') {
                    count--;
                }
                left++;
            }
        }

        return result;
    }
};