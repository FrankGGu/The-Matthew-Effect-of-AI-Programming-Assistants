#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countCompleteDayPairs(vector<int>& hours) {
        unordered_map<int, int> remainderCount;
        int count = 0;
        for (int hour : hours) {
            int rem = hour % 24;
            count += remainderCount[24 - rem];
            remainderCount[rem]++;
        }
        return count;
    }
};