class Solution {
public:
    int numberOfRounds(string startTime, string finishTime) {
        int startHour = stoi(startTime.substr(0, 2));
        int startMinute = stoi(startTime.substr(3, 2));
        int finishHour = stoi(finishTime.substr(0, 2));
        int finishMinute = stoi(finishTime.substr(3, 2));

        int startTotalMinutes = startHour * 60 + startMinute;
        int finishTotalMinutes = finishHour * 60 + finishMinute;

        if (finishTotalMinutes < startTotalMinutes) {
            finishTotalMinutes += 24 * 60;
        }

        int startRounds = (startTotalMinutes + 14) / 15;
        int finishRounds = finishTotalMinutes / 15;

        return max(0, finishRounds - startRounds);
    }
};