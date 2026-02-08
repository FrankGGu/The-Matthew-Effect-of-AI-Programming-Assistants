impl Solution {
    pub fn stone_game_ix(stones: Vec<i32>) -> bool {
        let mut c1 = 0; // Count of stones with value % 3 == 1
        let mut c2 = 0; // Count of stones with value % 3 == 2
        let mut s0 = 0; // Count of stones with value % 3 == 0

        for &stone in &stones {
            match stone % 3 {
                1 => c1 += 1,
                2 => c2 += 1,
                0 => s0 += 1,
                _ => {}
            }
        }

        // Case 1: Both types of stones (mod 3 = 1 and mod 3 = 2) are available
        // Alice can always win by forcing Bob to make the sum a multiple of 3.
        // For example, if Alice picks a stone with value % 3 = 1 (sum = 1),
        // Bob picks a stone with value % 3 = 1 (sum = 2),
        // Alice picks a stone with value % 3 = 2 (sum = 1),
        // Bob picks a stone with value % 3 = 2 (sum = 0). Bob loses.
        // This strategy works as long as both c1 and c2 are positive.
        // If c1=1, c2=ANY: A:v1 (sum=1). B has only v2. B:v2 (sum=0). B loses. A wins.
        // If c2=1, c1=ANY: A:v2 (sum=2). B has only v1. B:v1 (sum=0). B loses. A wins.
        if c1 > 0 && c2 > 0 {
            return true;
        }

        // Case 2: Only stones with value % 3 = 1 are available (c2 == 0)
        // Alice must pick a stone with value % 3 = 1. Sum becomes 1. c1 decreases.
        // Bob faces sum=1. Bob must pick a stone with value % 3 = 1. Sum becomes 2. c1 decreases.
        // Alice faces sum=2. Alice must pick a stone with value % 3 = 1. Sum becomes 0. Alice loses.
        // This pattern continues. The player who picks the 3rd stone (1,1,1) or (2,2,2) loses.
        // The s0 stones act as "pass" moves. If a player is forced to lose, they can use an s0 stone to pass the turn.
        // The parity of s0 determines who makes the critical move when s1/s2 stones run out.
        // If s0 is odd, the player who would have lost, wins. If s0 is even, the player who would have lost, loses.
        if c2 == 0 {
            // If c1 == 0, then all stones are %3 == 0. Alice picks one, sum is 0. Bob picks one, sum is 0.
            // This continues until all s0 stones are gone. The sum never becomes a multiple of 3 by s1/s2 stones.
            // The problem implies the game ends. If it never ends, Alice cannot win. So Alice loses.
            // If c1 == 0 && c2 == 0, Alice loses.
            // If c1 == 1: Alice picks v1. Sum=1. c1=0. Bob faces sum=1, no s1/s2.
            //   If s0 is odd, Alice wins. If s0 is even, Bob wins.
            // If c1 == 2: Alice picks v1. Sum=1. c1=1. Bob picks v1. Sum=2. c1=0. Alice faces sum=2, no s1/s2.
            //   If s0 is odd, Alice wins. If s0 is even, Bob wins.
            // If c1 > 2: Alice picks v1. Sum=1. c1=c1-1. Bob picks v1. Sum=2. c1=c1-2. Alice picks v1. Sum=0. Alice loses. Bob wins.
            // This means if c1 > 2, Bob wins.
            return c1 > 0 && c1 <= 2 && s0 % 2 == 1;
        }

        // Case 3: Only stones with value % 3 = 2 are available (c1 == 0)
        // Symmetric to Case 2.
        // Alice must pick a stone with value % 3 = 2. Sum becomes 2. c2 decreases.
        // Bob faces sum=2. Bob must pick a stone with value % 3 = 2. Sum becomes 1. c2 decreases.
        // Alice faces sum=1. Alice must pick a stone with value % 3 = 2. Sum becomes 0. Alice loses.
        // If c2 == 1: Alice picks v2. Sum=2. c2=0. Bob faces sum=2, no s1/s2.
        //   If s0 is odd, Alice wins. If s0 is even, Bob wins.
        // If c2 == 2: Alice picks v2. Sum=2. c2=1. Bob picks v2. Sum=1. c2=0. Alice faces sum=1, no s1/s2.
        //   If s0 is odd, Alice wins. If s0 is even, Bob wins.
        // If c2 > 2: Alice picks v2. Sum=2. c2=c2-1. Bob picks v2. Sum=1. c2=c2-2. Alice picks v2. Sum=0. Alice loses. Bob wins.
        // This means if c2 > 2, Bob wins.
        if c1 == 0 {
            return c2 > 0 && c2 <= 2 && s0 % 2 == 1;
        }

        false // Should not be reached given the conditions above
    }
}