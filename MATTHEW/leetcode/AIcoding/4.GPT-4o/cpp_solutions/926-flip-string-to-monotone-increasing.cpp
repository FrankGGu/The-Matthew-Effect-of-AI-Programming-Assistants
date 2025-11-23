class Solution {
public:
    int minFlipsMonoIncr(string s) {
        int count0 = 0, count1 = 0;
        for (char c : s) {
            if (c == '0') {
                count0++;
            } else {
                count1++;
            }
            count1 = min(count1, count0);
        }
        return count1;
    }
};