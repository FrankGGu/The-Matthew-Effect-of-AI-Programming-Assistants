#include <vector>

using namespace std;

class Solution {
public:
    long long countDaysWithoutMeetings(vector<int>& meetings) {
        long long ans = 0;
        long long curr = 0;
        for (int meeting : meetings) {
            long long days = (meeting - 1 + 24) / 24;
            if (curr < days) {
                ans += (days - curr);
                curr = days;
            }
            curr += (meeting + 23) / 24;
        }
        return ans;
    }
};