class Solution {
public:
    int minOperations(string s) {
        int count1 = 0, count2 = 0;
        for (int i = 0; i < s.size(); i++) {
            if (s[i] != '0' + (i % 2)) count1++;
            if (s[i] != '1' - (i % 2)) count2++;
        }
        return min(count1, count2);
    }
};