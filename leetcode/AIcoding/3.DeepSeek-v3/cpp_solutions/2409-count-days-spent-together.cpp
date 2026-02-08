class Solution {
public:
    int countDaysTogether(string arriveAlice, string leaveAlice, string arriveBob, string leaveBob) {
        vector<int> days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        auto getDay = [&](string date) {
            int month = stoi(date.substr(0, 2));
            int day = stoi(date.substr(3));
            int total = 0;
            for (int i = 0; i < month - 1; ++i) {
                total += days[i];
            }
            total += day;
            return total;
        };

        int aliceArrive = getDay(arriveAlice);
        int aliceLeave = getDay(leaveAlice);
        int bobArrive = getDay(arriveBob);
        int bobLeave = getDay(leaveBob);

        int start = max(aliceArrive, bobArrive);
        int end = min(aliceLeave, bobLeave);

        return max(0, end - start + 1);
    }
};