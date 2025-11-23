class Solution {
public:
    int minSwaps(string s) {
        int count1 = 0, count0 = 0;
        for (char c : s) {
            if (c == '1') count1++;
            else count0++;
        }
        if (abs(count1 - count0) > 1) return -1;

        int swaps1 = 0, swaps0 = 0;
        for (int i = 0; i < s.size(); i++) {
            char expected = (i % 2 == 0) ? '1' : '0';
            if (s[i] != expected) swaps1++;
        }
        for (int i = 0; i < s.size(); i++) {
            char expected = (i % 2 == 0) ? '0' : '1';
            if (s[i] != expected) swaps0++;
        }

        if (count1 > count0) return swaps1 / 2;
        else if (count0 > count1) return swaps0 / 2;
        else return min(swaps1 / 2, swaps0 / 2);
    }
};