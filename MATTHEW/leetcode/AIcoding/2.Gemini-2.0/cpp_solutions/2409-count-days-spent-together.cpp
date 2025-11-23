class Solution {
public:
    int daysBetween(int month, int day, int year) {
        vector<int> daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            daysInMonth[2] = 29;
        }
        int days = 0;
        for (int i = 1; i < month; ++i) {
            days += daysInMonth[i];
        }
        days += day;
        return days;
    }

    int countDaysTogether(string arriveAlice, string leaveAlice, string arriveBob, string leaveBob) {
        int arriveAliceMonth = stoi(arriveAlice.substr(0, 2));
        int arriveAliceDay = stoi(arriveAlice.substr(3, 2));
        int leaveAliceMonth = stoi(leaveAlice.substr(0, 2));
        int leaveAliceDay = stoi(leaveAlice.substr(3, 2));
        int arriveBobMonth = stoi(arriveBob.substr(0, 2));
        int arriveBobDay = stoi(arriveBob.substr(3, 2));
        int leaveBobMonth = stoi(leaveBob.substr(0, 2));
        int leaveBobDay = stoi(leaveBob.substr(3, 2));

        int arriveAliceDays = daysBetween(arriveAliceMonth, arriveAliceDay, 2023);
        int leaveAliceDays = daysBetween(leaveAliceMonth, leaveAliceDay, 2023);
        int arriveBobDays = daysBetween(arriveBobMonth, arriveBobDay, 2023);
        int leaveBobDays = daysBetween(leaveBobMonth, leaveBobDay, 2023);

        int start = max(arriveAliceDays, arriveBobDays);
        int end = min(leaveAliceDays, leaveBobDays);

        return max(0, end - start + 1);
    }
};