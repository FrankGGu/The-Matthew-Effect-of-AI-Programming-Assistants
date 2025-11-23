class Solution {
public:
    int countTime(string time) {
        int count = 0;
        int h1 = time[0] == '?' ? 3 : time[0] - '0';
        int h2 = time[1] == '?' ? (h1 < 2 ? 10 : 4) : time[1] - '0';
        int m1 = time[3] == '?' ? 6 : time[3] - '0';
        int m2 = time[4] == '?' ? 10 : time[4] - '0';

        for (int i = 0; i < (time[0] == '?' ? 3 : 1); ++i) {
            for (int j = 0; j < (time[1] == '?' ? h2 : 1); ++j) {
                for (int k = 0; k < (time[3] == '?' ? 6 : 1); ++k) {
                    for (int l = 0; l < (time[4] == '?' ? 10 : 1); ++l) {
                        int hour = (time[0] == '?' ? i : h1) * 10 + (time[1] == '?' ? j : h2);
                        int minute = (time[3] == '?' ? k : m1) * 10 + (time[4] == '?' ? l : m2);
                        if (hour < 24 && minute < 60) {
                            count++;
                        }
                    }
                }
            }
        }
        return count;
    }
};