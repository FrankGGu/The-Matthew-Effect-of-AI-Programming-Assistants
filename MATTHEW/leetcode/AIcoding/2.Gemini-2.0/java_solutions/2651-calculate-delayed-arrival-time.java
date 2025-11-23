class Solution {
    public int getArrival(int arrivalTime, int delayedTime) {
        return (arrivalTime + delayedTime) % 24;
    }
}