class Solution {
public:
    int numWaterBottles(int numBottles, int numExchange) {
        int totalDrunk = numBottles;
        while (numBottles >= numExchange) {
            int exchanged = numBottles / numExchange;
            totalDrunk += exchanged;
            numBottles = exchanged + (numBottles % numExchange);
        }
        return totalDrunk;
    }
};