#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countDaysTogether(string arriveAlice, string leaveAlice, string arriveBob, string leaveBob) {
        const int prefixSum[] = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334};

        auto dateToDay = [&](const string& date) {
            int month = stoi(date.substr(0, 2));
            int day = stoi(date.substr(3, 2));
            return prefixSum[month - 1] + day;
        };

        int alice_arrive = dateToDay(arriveAlice);
        int alice_leave = dateToDay(leaveAlice);
        int bob_arrive = dateToDay(arriveBob);
        int bob_leave = dateToDay(leaveBob);

        int start_overlap = max(alice_arrive, bob_arrive);
        int end_overlap = min(alice_leave, bob_leave);

        return max(0, end_overlap - start_overlap + 1);
    }
};