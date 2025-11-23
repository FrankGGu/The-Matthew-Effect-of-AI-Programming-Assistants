class Solution {
    public int waterBottle(int numBottles, int numExchange) {
        int totalWater = numBottles;
        int emptyBottles = numBottles;

        while (emptyBottles >= numExchange) {
            int newBottles = emptyBottles / numExchange;
            totalWater += newBottles;
            emptyBottles = newBottles + (emptyBottles % numExchange);
        }

        return totalWater;
    }
}