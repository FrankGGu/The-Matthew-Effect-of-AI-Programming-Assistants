class Solution {
    public int numWaterBottles(int numBottles, int numExchange) {
        int drunkBottles = numBottles;
        int emptyBottles = numBottles;

        while (emptyBottles >= numExchange) {
            int newBottles = emptyBottles / numExchange;
            drunkBottles += newBottles;
            emptyBottles = (emptyBottles % numExchange) + newBottles;
        }

        return drunkBottles;
    }
}