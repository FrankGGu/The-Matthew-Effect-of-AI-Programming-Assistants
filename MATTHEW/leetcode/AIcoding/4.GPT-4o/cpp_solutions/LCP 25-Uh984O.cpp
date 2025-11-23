class Solution {
public:
    int minimumTime(string time) {
        int hours = stoi(time.substr(0, 2));
        int minutes = stoi(time.substr(3, 2));
        int totalMinutes = hours * 60 + minutes;

        int totalTime = 0;
        while (totalTime < totalMinutes) {
            if (totalTime % 60 == minutes % 60 && totalTime / 60 % 24 == hours % 24) {
                return totalTime;
            }
            totalTime++;
        }

        return totalTime;
    }
};