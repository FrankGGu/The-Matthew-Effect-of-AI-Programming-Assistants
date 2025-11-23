class Solution {
public:
    string maxValue(string n, int x) {
        bool isNegative = (n[0] == '-');
        int pos = isNegative ? 1 : 0;
        while (pos < n.size()) {
            if (isNegative) {
                if (n[pos] - '0' > x) {
                    break;
                }
            } else {
                if (n[pos] - '0' < x) {
                    break;
                }
            }
            pos++;
        }
        n.insert(pos, to_string(x));
        return n;
    }
};