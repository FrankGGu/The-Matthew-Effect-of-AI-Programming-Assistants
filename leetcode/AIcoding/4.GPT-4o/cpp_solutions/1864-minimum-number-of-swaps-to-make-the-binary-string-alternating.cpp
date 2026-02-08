class Solution {
public:
    int minSwaps(string s) {
        int n = s.size();
        int count0 = count(s.begin(), s.end(), '0');
        int count1 = n - count0;

        if (abs(count0 - count1) > 1) return -1;

        int swaps1 = 0, swaps2 = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                if (s[i] == '1') swaps1++;
                if (s[i] == '0') swaps2++;
            } else {
                if (s[i] == '0') swaps1++;
                if (s[i] == '1') swaps2++;
            }
        }

        if (count0 > count1) {
            return swaps2;
        } else if (count1 > count0) {
            return swaps1;
        } else {
            return min(swaps1, swaps2);
        }
    }
};