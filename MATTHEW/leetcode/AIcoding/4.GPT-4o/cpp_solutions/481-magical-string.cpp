class Solution {
public:
    int magicalString(int n) {
        if (n == 0) return 0;
        if (n == 1) return 1;

        string s = "122";
        int count = 1;
        int index = 2;

        while (s.size() < n) {
            int num = s[index] - '0';
            char nextChar = (count % 2 == 0) ? '1' : '2';
            s.append(num, nextChar);
            count += num;
            index++;
        }

        return count + (s[n - 1] == '1' ? 0 : 1);
    }
};