class Solution {
public:
    int maximumValue(vector<string>& strs) {
        int max_val = 0;
        for (const string& s : strs) {
            bool is_numeric = true;
            for (char c : s) {
                if (!isdigit(c)) {
                    is_numeric = false;
                    break;
                }
            }
            int val = is_numeric ? stoi(s) : s.length();
            max_val = max(max_val, val);
        }
        return max_val;
    }
};