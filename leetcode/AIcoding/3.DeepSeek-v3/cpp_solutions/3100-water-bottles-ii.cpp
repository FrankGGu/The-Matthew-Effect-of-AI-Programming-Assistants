class Solution {
public:
    int maxBottlesDrunk(int numBottles, int numExchange) {
        int total = numBottles;
        int empty = numBottles;
        while (empty >= numExchange) {
            int exchanged = empty / numExchange;
            total += exchanged;
            empty = empty % numExchange + exchanged;
            numExchange++;
        }
        return total;
    }
};