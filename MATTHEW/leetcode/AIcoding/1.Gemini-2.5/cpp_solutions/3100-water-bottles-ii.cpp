class Solution {
public:
    int maxBottlesDrunk(int numBottles, int numExchange) {
        int drunkBottles = numBottles;
        int emptyBottles = numBottles;
        bool specialExchangeUsed = false;

        while (true) {
            int newBottlesFromExchange = 0;

            // Prioritize regular exchange
            if (emptyBottles >= numExchange) {
                newBottlesFromExchange = emptyBottles / numExchange;
                emptyBottles %= numExchange;
                drunkBottles += newBottlesFromExchange;
                emptyBottles += newBottlesFromExchange; // These new bottles become empty after drinking
            } 
            // Then check for special exchange if no regular exchange was possible
            // and special exchange hasn't been used yet and conditions are met
            else if (!specialExchangeUsed && emptyBottles >= numExchange - 1) {
                // Special exchange: get 1 bottle for numExchange - 1 empty bottles
                newBottlesFromExchange = 1;
                emptyBottles -= (numExchange - 1);
                specialExchangeUsed = true;
                drunkBottles += newBottlesFromExchange;
                emptyBottles += newBottlesFromExchange; // This new bottle becomes empty after drinking
            } else {
                // No more exchanges possible, neither regular nor special
                break;
            }
        }

        return drunkBottles;
    }
};