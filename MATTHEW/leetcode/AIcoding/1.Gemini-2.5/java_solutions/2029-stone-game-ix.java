class Solution {
    public boolean stoneGameIX(int[] stones) {
        int count0 = 0;
        int count1 = 0;
        int count2 = 0;

        for (int stone : stones) {
            int remainder = stone % 3;
            if (remainder == 0) {
                count0++;
            } else if (remainder == 1) {
                count1++;
            } else { // remainder == 2
                count2++;
            }
        }

        // Case 1: Alice cannot make a valid first move.
        // Alice starts with sum = 0. She must pick a stone x such that (0 + x) % 3 != 0.
        // This means she cannot pick a stone with remainder 0.
        // If there are no stones with remainder 1 or 2, Alice cannot make a move and loses.
        if (count1 == 0 && count2 == 0) {
            return false;
        }

        // Case 2: Even number of stones with remainder 0.
        // Stones with remainder 0 can only be picked when the current sum % 3 is 1 or 2.
        // Picking a stone with remainder 0 does not change the sum % 3.
        // If count0 is even, these stones effectively cancel each other out in terms of turn parity for critical moves (moves using remainder 1 or 2 stones).
        // Alice makes the first critical move. She wins if she can make the last critical move.
        // If both count1 and count2 are available, Alice can always force a win.
        // If only count1 stones are available (count2 is 0), Alice wins if count1 is odd.
        // If only count2 stones are available (count1 is 0), Alice wins if count2 is odd.
        if (count0 % 2 == 0) {
            return (count1 > 0 && count2 > 0) || (count1 % 2 == 1 && count2 == 0) || (count2 % 2 == 1 && count1 == 0);
        }
        // Case 3: Odd number of stones with remainder 0.
        // If count0 is odd, these stones effectively flip whose turn it is for the critical moves.
        // Alice makes the first critical move. But the odd count0 means Bob effectively gets the "first" opportunity to make a game-ending critical move.
        // So Alice wins if Bob (as the "first" player in the critical game) would lose.
        // Bob would lose if (count1 > 0 && count2 > 0) AND (count1 is odd OR count2 is odd).
        // Therefore, Alice wins if (count1 > 0 && count2 > 0) AND (count1 is even AND count2 is even).
        // If only count1 stones are available (count2 is 0), Alice wins if count1 is even.
        // If only count2 stones are available (count1 is 0), Alice wins if count2 is even.
        else { // count0 % 2 == 1
            return (count1 > 0 && count2 > 0 && count1 % 2 == 0 && count2 % 2 == 0) || (count1 % 2 == 0 && count2 == 0 && count1 > 0) || (count2 % 2 == 0 && count1 == 0 && count2 > 0);
        }
    }
}