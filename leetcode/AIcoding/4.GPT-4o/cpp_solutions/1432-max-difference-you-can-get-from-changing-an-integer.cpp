class Solution {
public:
    int maximumDifference(int num) {
        string strNum = to_string(num);
        int maxDiff = 0;
        for (char& c : strNum) {
            for (char d = '0'; d <= '9'; ++d) {
                if (d != c) {
                    string newNum = strNum;
                    newNum[0] = d;
                    maxDiff = max(maxDiff, stoi(newNum) - num);
                }
            }
        }
        return maxDiff;
    }
};