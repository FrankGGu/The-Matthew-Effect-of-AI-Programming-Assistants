class Solution {
public:
    string longestDupSubstring(string s) {
        int n = s.size();
        int left = 1, right = n - 1;
        string result = "";

        auto search = [&](int len) {
            unordered_set<string> seen;
            string curr = s.substr(0, len);
            seen.insert(curr);
            for (int i = len; i < n; ++i) {
                curr = curr.substr(1) + s[i];
                if (seen.count(curr)) {
                    return curr;
                }
                seen.insert(curr);
            }
            return string();
        };

        while (left <= right) {
            int mid = left + (right - left) / 2;
            string found = search(mid);
            if (!found.empty()) {
                result = found;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }
};