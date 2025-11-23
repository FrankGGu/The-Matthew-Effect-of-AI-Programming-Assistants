class Solution {
public:
    string digitSum(string s, int k) {
        while (s.size() > k) {
            stringstream ss;
            for (int i = 0; i < s.size(); i += k) {
                int sum = 0;
                for (int j = 0; j < k && i + j < s.size(); j++) {
                    sum += s[i + j] - '0';
                }
                ss << sum;
            }
            s = ss.str();
        }
        return s;
    }
};