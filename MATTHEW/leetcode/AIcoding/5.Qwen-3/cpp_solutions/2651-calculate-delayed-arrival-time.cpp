#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int calculateDelayedArrivalTime(int arrivalTime, int delayedTime) {
        return (arrivalTime + delayedTime) % 24;
    }
};