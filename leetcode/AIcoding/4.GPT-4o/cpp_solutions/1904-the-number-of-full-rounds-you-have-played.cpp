class Solution {
public:
    int numberOfRounds(string startTime, string finishTime) {
        int startHour = stoi(startTime.substr(0, 2));
        int startMinute = stoi(startTime.substr(3, 2));
        int finishHour = stoi(finishTime.substr(0, 2));
        int finishMinute = stoi(finishTime.substr(3, 2));

        if (finishHour < startHour || (finishHour == startHour && finishMinute < startMinute)) {
            finishHour += 24;
        }

        int totalStartMinutes = startHour * 60 + startMinute;
        int totalFinishMinutes = finishHour * 60 + finishMinute;

        totalStartMinutes = (totalStartMinutes + 14) / 15 * 15; // Round up to the next full round
        totalFinishMinutes = totalFinishMinutes / 15 * 15; // Round down to the last full round

        return max(0, (totalFinishMinutes - totalStartMinutes) / 15);
    }
};