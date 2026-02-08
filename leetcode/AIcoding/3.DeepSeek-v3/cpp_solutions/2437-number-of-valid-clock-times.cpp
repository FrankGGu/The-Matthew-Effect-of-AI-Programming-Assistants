class Solution {
public:
    int countTime(string time) {
        int count = 1;
        if (time[0] == '?' && time[1] == '?') {
            count *= 24;
        } else if (time[0] == '?') {
            if (time[1] - '0' < 4) {
                count *= 3;
            } else {
                count *= 2;
            }
        } else if (time[1] == '?') {
            if (time[0] - '0' < 2) {
                count *= 10;
            } else {
                count *= 4;
            }
        }

        if (time[3] == '?' && time[4] == '?') {
            count *= 60;
        } else if (time[3] == '?') {
            count *= 6;
        } else if (time[4] == '?') {
            count *= 10;
        }

        return count;
    }
};