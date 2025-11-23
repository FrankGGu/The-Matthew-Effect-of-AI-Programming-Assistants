class Solution {
public:
    int magicalString(int n) {
        if (n == 0) return 0;
        if (n <= 3) return 1;

        string s = "122";
        int i = 2;
        int count = 1;

        while (s.size() < n) {
            char last = s.back();
            char next = (last == '1') ? '2' : '1';
            int repeat = s[i] - '0';
            for (int j = 0; j < repeat; ++j) {
                s += next;
                if (s.size() <= n && next == '1') {
                    count++;
                }
            }
            i++;
        }

        return count;
    }
};