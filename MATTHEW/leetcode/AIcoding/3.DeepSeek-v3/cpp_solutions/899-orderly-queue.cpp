class Solution {
public:
    string orderlyQueue(string s, int k) {
        if (k == 1) {
            string res = s;
            for (int i = 1; i < s.size(); ++i) {
                string temp = s.substr(i) + s.substr(0, i);
                if (temp < res) {
                    res = temp;
                }
            }
            return res;
        } else {
            sort(s.begin(), s.end());
            return s;
        }
    }
};