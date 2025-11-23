class Solution {
public:
    int convertTime(string current, string correct) {
        int currMinutes = stoi(current.substr(0, 2)) * 60 + stoi(current.substr(3, 2));
        int corrMinutes = stoi(correct.substr(0, 2)) * 60 + stoi(correct.substr(3, 2));
        int diff = corrMinutes - currMinutes;
        if (diff < 0) return 0;

        int operations = 0;
        int timeUnits[] = {60, 15, 5, 1};

        for (int unit : timeUnits) {
            operations += diff / unit;
            diff %= unit;
        }
        return operations;
    }
};