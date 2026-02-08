class Solution {
public:
    string repeatLimitedString(string s, int repeatLimit) {
        int count[26] = {0};
        for (char c : s) {
            count[c - 'a']++;
        }
        string res;
        int last = -1;
        while (true) {
            int maxChar = -1;
            for (int i = 25; i >= 0; --i) {
                if (count[i] > 0 && i != last) {
                    maxChar = i;
                    break;
                }
            }
            if (maxChar == -1) break;
            int use = min(count[maxChar], maxChar == last ? 1 : repeatLimit);
            res += string(use, 'a' + maxChar);
            count[maxChar] -= use;
            last = maxChar;
            if (count[maxChar] > 0) {
                int nextChar = -1;
                for (int i = maxChar - 1; i >= 0; --i) {
                    if (count[i] > 0) {
                        nextChar = i;
                        break;
                    }
                }
                if (nextChar == -1) break;
                res += string(1, 'a' + nextChar);
                count[nextChar]--;
                last = nextChar;
            }
        }
        return res;
    }
};