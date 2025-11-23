class Solution {
public:
    vector<long long> findDelayedArrivalTime(int arrivalTime, int delayedTime) {
        long long total = arrivalTime + delayedTime;
        return {total % 24, total / 24};
    }
};