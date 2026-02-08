class Solution {
public:
    int minInsertions(string s) {
        int res = 0, need = 0;
        for (char c : s) {
            if (c == '(') {
                need += 2;
                if (need % 2 == 1) {
                    res++;
                    need--;
                }
            } else {
                need--;
                if (need < 0) {
                    res++;
                    need += 2;
                }
            }
        }
        return res + need;
    }
};