#include <vector>
#include <numeric>
#include <cmath>
#include <algorithm>

class Solution {
public:
    bool stoneGameIX(std::vector<int>& stones) {
        int count0 = 0;
        int count1 = 0;
        int count2 = 0;

        for (int stone : stones) {
            if (stone % 3 == 0) {
                count0++;
            } else if (stone % 3 == 1) {
                count1++;
            } else { // stone % 3 == 2
                count2++;
            }
        }

        // Case 1: No stones with value % 3 == 1 or % 3 == 2
        // Alice starts with sum = 0. She cannot take a stone with value % 3 == 0.
        // So, she cannot make a move. Alice loses.
        if (count1 == 0 && count2 == 0) {
            return false;
        }

        // Case 2: Only stones with value % 3 == 1 (and possibly % 3 == 0)
        // Alice must take a stone with value % 3 == 1. Sum becomes 1.
        // Bob faces sum = 1.
        // If count1 was 1, Bob faces sum = 1, no more 1-mod-3 stones.
        //   - If count0 == 0, Bob cannot move. Alice wins.
        //   - If count0 > 0, Bob takes a 0-mod-3 stone, sum remains 1.
        //     The game reduces to players alternating taking 0-mod-3 stones.
        //     The player who takes the last 0-mod-3 stone wins.
        //     If count0 is even, Alice takes the last. Alice wins.
        //     If count0 is odd, Bob takes the last. Bob wins.
        // If count1 > 1, Bob faces sum = 1, count1-1 stones of type 1.
        //   - Bob can take a 1-mod-3 stone (sum becomes 2) or a 0-mod-3 stone (sum remains 1).
        //   - This leads to a similar pattern as above, where the parity of count0 determines the winner.
        // In general, if only one type (1-mod-3 or 2-mod-3) is available initially, Alice wins if count0 is even.
        if (count1 == 0) { // count2 > 0
            return count0 % 2 == 0;
        }
        if (count2 == 0) { // count1 > 0
            return count0 % 2 == 0;
        }

        // Case 3: Both types of stones (1-mod-3 and 2-mod-3) are available
        // Alice starts with sum = 0. She can choose to take a 1-mod-3 or 2-mod-3 stone.
        // The 0-mod-3 stones can be used to "pass" a turn without changing sum % 3,
        // as long as sum % 3 is not 0.

        // Subcase 3.1: count0 is even
        // The 0-mod-3 stones effectively cancel each other out in pairs.
        // Alice can always make a move that leaves Bob in a non-losing position.
        // As long as both count1 and count2 are greater than 0, Alice can always make a move.
        // Alice wins.
        if (count0 % 2 == 0) {
            return true;
        }

        // Subcase 3.2: count0 is odd
        // Bob effectively gets an "extra" turn because he can use the first 0-mod-3 stone
        // to pass the turn back to Alice, with count0 now even.
        // Alice takes a stone (e.g., 1-mod-3, sum becomes 1).
        // Bob takes a 0-mod-3 stone (sum remains 1). count0 is now even.
        // Alice faces sum=1, count1-1 stones of type 1, count2 stones of type 2.
        // If Alice took a 2-mod-3 stone, Bob takes a 0-mod-3 stone.
        // Alice faces sum=2, count1 stones of type 1, count2-1 stones of type 2.
        // In this scenario, Alice loses if she is forced into a situation where she cannot move.
        // This happens if she faces sum=1 and has no 1-mod-3 stones (and no 0-mod-3 stones left).
        // Or if she faces sum=2 and has no 2-mod-3 stones (and no 0-mod-3 stones left).
        // This occurs if Alice starts with (count1=1, count2>0) and takes the 1-mod-3 stone,
        // or (count1>0, count2=1) and takes the 2-mod-3 stone.
        // So, if count0 is odd, Alice loses if min(count1, count2) == 1.
        // Alice wins if both count1 > 1 and count2 > 1.
        return std::min(count1, count2) > 1;
    }
};