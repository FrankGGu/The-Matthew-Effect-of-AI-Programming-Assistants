class Solution {
public:
    int countDaysTogether(string arriveAlice, string leaveAlice, string arriveBob, string leaveBob) {
        int daysAliceStart = dateToDays(arriveAlice);
        int daysAliceEnd = dateToDays(leaveAlice);
        int daysBobStart = dateToDays(arriveBob);
        int daysBobEnd = dateToDays(leaveBob);

        int start = max(daysAliceStart, daysBobStart);
        int end = min(daysAliceEnd, daysBobEnd);

        return max(0, end - start + 1);
    }

private:
    int dateToDays(string date) {
        int month = stoi(date.substr(0, 2));
        int day = stoi(date.substr(3, 2));
        return (month - 1) * 31 + day;
    }
};