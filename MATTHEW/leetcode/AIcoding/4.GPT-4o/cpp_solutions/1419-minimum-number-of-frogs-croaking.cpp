class Solution {
public:
    int minNumberOfFrogs(string croakOfFrogs) {
        vector<int> count(5, 0);
        int maxFrogs = 0;

        for (char c : croakOfFrogs) {
            if (c == 'c') count[0]++;
            else if (c == 'r') count[1]++;
            else if (c == 'o') count[2]++;
            else if (c == 'a') count[3]++;
            else if (c == 'k') count[4]++;

            for (int i = 1; i < 5; i++) {
                if (count[i] > count[i - 1]) return -1;
            }
            maxFrogs = max(maxFrogs, count[0] - count[4]);
        }

        return count[0] == count[4] ? maxFrogs : -1;
    }
};