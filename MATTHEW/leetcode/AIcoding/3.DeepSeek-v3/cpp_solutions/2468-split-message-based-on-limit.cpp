class Solution {
public:
    vector<string> splitMessage(string message, int limit) {
        vector<string> result;
        int n = message.size();
        int parts = 0;

        for (int k = 1; k <= n; ++k) {
            int suffix_len = 3 + to_string(k).length() * 2;
            if (to_string(k).length() != to_string(k - 1).length()) {
                suffix_len = 3 + to_string(k).length() * 2;
            }
            if (limit <= suffix_len) {
                return {};
            }
            int max_possible = k * (limit - suffix_len);
            if (max_possible >= n) {
                parts = k;
                break;
            }
        }

        if (parts == 0) {
            return {};
        }

        int pos = 0;
        for (int i = 1; i <= parts; ++i) {
            string suffix = "<" + to_string(i) + "/" + to_string(parts) + ">";
            int max_chars = limit - suffix.length();
            if (max_chars <= 0) {
                return {};
            }
            string part = message.substr(pos, max_chars) + suffix;
            result.push_back(part);
            pos += max_chars;
        }

        return result;
    }
};