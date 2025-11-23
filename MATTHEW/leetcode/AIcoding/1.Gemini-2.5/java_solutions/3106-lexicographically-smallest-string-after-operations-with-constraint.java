class Solution {
    public String getSmallestString(String s, int k) {
        char[] chars = s.toCharArray();
        int n = chars.length;

        for (int i = 0; i < n; i++) {
            int bestTargetDigitVal = 10; // Represents a digit '0' through '9', 10 means no valid digit found yet
            int bestSourceIndex = -1;
            int minCost = Integer.MAX_VALUE;

            // Iterate through all possible characters in the remaining suffix (from i to n-1)
            // to find the best character to place at the current position i.
            for (int j = i; j < n; j++) {
                int currentCharVal = chars[j] - '0';

                // Iterate through all possible target digits ('0' to '9')
                for (int targetDigitVal = 0; targetDigitVal <= 9; targetDigitVal++) {
                    // Calculate the cost to change currentCharVal to targetDigitVal
                    // (targetDigitVal - currentCharVal + 10) % 10 handles wrap-around from 9 to 0
                    int cost = (targetDigitVal - currentCharVal + 10) % 10;

                    if (cost <= k) {
                        // Found a valid operation within the remaining budget k
                        if (targetDigitVal < bestTargetDigitVal) {
                            // This target digit is smaller than the current best, so it's the new best.
                            bestTargetDigitVal = targetDigitVal;
                            bestSourceIndex = j;
                            minCost = cost;
                            // Optimization: if we found '0', no need to check other target digits for this j,
                            // as '0' is the smallest possible.
                            if (bestTargetDigitVal == 0) {
                                break; 
                            }
                        } else if (targetDigitVal == bestTargetDigitVal) {
                            // Same target digit, check if this option is better based on cost or index.
                            if (cost < minCost) {
                                // Lower cost is better
                                minCost = cost;
                                bestSourceIndex = j;
                            } else if (cost == minCost) {
                                // Same cost, prefer the character that is closer to the current position i (smaller j)
                                // because it requires less "movement" of other characters in the suffix
                                // (though swaps are free, this ensures deterministic behavior and potentially
                                // less overall data movement).
                                if (j < bestSourceIndex) {
                                    bestSourceIndex = j;
                                }
                            }
                        }
                    }
                }
            }

            // Apply the chosen operation for position i
            k -= minCost;

            // Perform the swap: move the character from bestSourceIndex to current position i.
            // The character originally at chars[i] moves to bestSourceIndex.
            char temp = chars[i];
            chars[i] = chars[bestSourceIndex];
            chars[bestSourceIndex] = temp;

            // Change the character at chars[i] to the bestTargetDigitVal.
            chars[i] = (char)(bestTargetDigitVal + '0');
        }

        return new String(chars);
    }
}