class Solution {
public:
    int maxDiff(int num) {
        string s = to_string(num);
        string max_s = s;
        string min_s = s;

        // Find the maximum number
        for (char &c : max_s) {
            if (c != '9') {
                char replace = c;
                for (char &ch : max_s) {
                    if (ch == replace) {
                        ch = '9';
                    }
                }
                break;
            }
        }

        // Find the minimum number
        if (min_s[0] != '1') {
            char replace = min_s[0];
            for (char &c : min_s) {
                if (c == replace) {
                    c = '1';
                }
            }
        } else {
            for (int i = 1; i < min_s.size(); ++i) {
                if (min_s[i] != '0' && min_s[i] != '1') {
                    char replace = min_s[i];
                    for (char &c : min_s) {
                        if (c == replace) {
                            c = '0';
                        }
                    }
                    break;
                }
            }
        }

        int max_num = stoi(max_s);
        int min_num = stoi(min_s);
        return max_num - min_num;
    }
};