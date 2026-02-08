class Solution {
public:
    int minMaxDifference(int num) {
        string s = to_string(num);
        string max_s = s;
        string min_s = s;
        char target_max = s[0];
        char target_min = s[0];
        for (char c : s) {
            if (c != '9') {
                target_max = c;
                break;
            }
        }
        for (int i = 0; i < s.size(); ++i) {
            if (max_s[i] == target_max) {
                max_s[i] = '9';
            }
            if (min_s[i] == target_min) {
                min_s[i] = '0';
            }
        }
        return stoi(max_s) - stoi(min_s);
    }
};