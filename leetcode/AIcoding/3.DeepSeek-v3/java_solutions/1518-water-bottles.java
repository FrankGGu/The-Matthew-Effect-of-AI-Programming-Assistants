class Solution {
    public int numWaterBottles(int numBottles, int numExchange) {
        int total = numBottles;
        int empty = numBottles;
        while (empty >= numExchange) {
            int exchanged = empty / numExchange;
            total += exchanged;
            empty = exchanged + (empty % numExchange);
        }
        return total;
    }
}