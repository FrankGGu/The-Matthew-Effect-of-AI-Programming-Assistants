class Solution {
public:
    string minimizeResult(string expression) {
        int plus_pos = expression.find('+');
        string left = expression.substr(0, plus_pos);
        string right = expression.substr(plus_pos + 1);
        int min_val = INT_MAX;
        string res;

        for (int i = 0; i < left.size(); ++i) {
            for (int j = 1; j <= right.size(); ++j) {
                string a_str = left.substr(0, i);
                string b_str = left.substr(i);
                string c_str = right.substr(0, j);
                string d_str = right.substr(j);

                int a = a_str.empty() ? 1 : stoi(a_str);
                int b = stoi(b_str);
                int c = stoi(c_str);
                int d = d_str.empty() ? 1 : stoi(d_str);

                int val = a * (b + c) * d;
                if (val < min_val) {
                    min_val = val;
                    res = a_str + "(" + b_str + "+" + c_str + ")" + d_str;
                }
            }
        }
        return res;
    }
};