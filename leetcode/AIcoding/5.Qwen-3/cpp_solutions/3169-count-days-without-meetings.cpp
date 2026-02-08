#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countDaysWithoutMeetings(vector<int>& days) {
        unordered_set<int> daySet(days.begin(), days.end());
        int count = 0;
        for (int i = 1; i <= 365; ++i) {
            if (daySet.find(i) == daySet.end()) {
                ++count;
            }
        }
        return count;
    }
};