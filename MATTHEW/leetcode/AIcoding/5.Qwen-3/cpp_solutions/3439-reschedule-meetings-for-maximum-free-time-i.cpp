#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> rescheduleMeetings(vector<vector<int>>& meetings) {
        sort(meetings.begin(), meetings.end());
        vector<int> freeTime;
        int prevEnd = 0;
        for (const auto& meeting : meetings) {
            int start = meeting[0];
            int end = meeting[1];
            if (start > prevEnd) {
                freeTime.push_back(prevEnd);
                freeTime.push_back(start);
            }
            prevEnd = max(prevEnd, end);
        }
        return freeTime;
    }
};