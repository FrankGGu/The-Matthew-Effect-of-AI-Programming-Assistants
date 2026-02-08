class Solution {
    public int calculateDelayedArrivalTime(int arrivalTime, int delayTime) {
        return (arrivalTime + delayTime) % 24;
    }
}