class Solution {
public:
    string maxValue(string n, int x) {
        char ch = x + '0';
        if (n[0] == '-') {
            for (int i = 1; i < n.size(); i++) {
                if (n[i] - '0' > x) {
                    n.insert(i, 1, ch);
                    return n;
                }
            }
            n += ch;
        } else {
            for (int i = 0; i < n.size(); i++) {
                if (n[i] - '0' < x) {
                    n.insert(i, 1, ch);
                    return n;
                }
            }
            n += ch;
        }
        return n;
    }
};