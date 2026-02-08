class Solution {
public:
    int minFlips(string s) {
        int n = s.size();
        s += s; // Concatenate the string to handle the circular nature
        int count1 = 0, count2 = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] != '0' + (i % 2)) count1++;
            if (s[i] != '1' - (i % 2)) count2++;
        }
        int res = min(count1, count2);
        for (int i = n; i < s.size(); ++i) {
            if (s[i - n] != '0' + ((i - n) % 2)) count1--;
            if (s[i - n] != '1' - ((i - n) % 2)) count2--;
            if (s[i] != '0' + (i % 2)) count1++;
            if (s[i] != '1' - (i % 2)) count2++;
            res = min(res, min(count1, count2));
        }
        return res;
    }
};