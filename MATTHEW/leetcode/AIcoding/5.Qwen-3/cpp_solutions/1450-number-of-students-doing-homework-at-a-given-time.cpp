#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int busyStudent(vector<int>& startTime, vector<int>& endTime, int qTime) {
        int count = 0;
        for (int i = 0; i < startTime.size(); ++i) {
            if (startTime[i] <= qTime && endTime[i] >= qTime) {
                ++count;
            }
        }
        return count;
    }
};