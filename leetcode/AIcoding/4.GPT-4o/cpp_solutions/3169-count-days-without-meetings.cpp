class Solution {
public:
    int countDaysTogether(string arriveAlice, string leaveAlice, string arriveBob, string leaveBob) {
        int aStart = toDays(arriveAlice);
        int aEnd = toDays(leaveAlice);
        int bStart = toDays(arriveBob);
        int bEnd = toDays(leaveBob);

        int start = max(aStart, bStart);
        int end = min(aEnd, bEnd);

        return max(0, end - start + 1);
    }

private:
    int toDays(string date) {
        int month = stoi(date.substr(5, 2));
        int day = stoi(date.substr(8, 2));
        return (month - 1) * 30 + day; // Approximate days in month
    }
};