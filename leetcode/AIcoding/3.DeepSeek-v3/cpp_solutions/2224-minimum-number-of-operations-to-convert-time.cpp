class Solution {
public:
    int convertTime(string current, string correct) {
        int currentMinutes = stoi(current.substr(0, 2)) * 60 + stoi(current.substr(3, 2));
        int correctMinutes = stoi(correct.substr(0, 2)) * 60 + stoi(correct.substr(3, 2));
        int diff = correctMinutes - currentMinutes;
        int operations = 0;

        operations += diff / 60;
        diff %= 60;

        operations += diff / 15;
        diff %= 15;

        operations += diff / 5;
        diff %= 5;

        operations += diff;

        return operations;
    }
};