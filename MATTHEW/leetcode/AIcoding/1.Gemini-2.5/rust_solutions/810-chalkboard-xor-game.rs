impl Solution {
    pub fn chalkboard_xor_game(nums: Vec<i32>) -> bool {
        let xor_sum = nums.iter().fold(0, |acc, &x| acc ^ x);

        if xor_sum == 0 {
            true
        } else {
            // If the XOR sum is not 0, the game proceeds.
            // In this scenario, the game effectively becomes a misere play game
            // where the player who cannot make a move (i.e., faces an empty chalkboard) loses.
            // The XOR sum condition (winning by making XOR sum 0 for the opponent)
            // interacts with the number of elements.
            //
            // If the number of elements N is even:
            // Alice can always make a move such that the new XOR sum is non-zero.
            // (If the current XOR sum S is not 0 and N is even, it's impossible for all elements to be S,
            // because S ^ S ^ ... ^ S (N times) would be 0, contradicting S != 0.
            // So there's always an x != S. Alice picks such an x, making S^x != 0.)
            // Bob then faces an odd number of elements and a non-zero XOR sum.
            // Bob cannot force a win (either by making XOR sum 0 for Alice, or by forcing N=0).
            // This continues, and eventually, Bob will be forced to face N=0 and lose.
            // Thus, Alice wins.
            //
            // If the number of elements N is odd:
            // Alice's turn. N is odd, S is not 0.
            // Alice makes a move. Bob faces an even number of elements.
            // If Alice can pick x such that S^x == 0 (i.e., x == S and S is present), Bob wins immediately.
            // If Alice picks x such that S^x != 0 (i.e., x != S, or S is not present),
            // Bob faces an even number of elements and a non-zero XOR sum.
            // From this position, Bob can win (as described in the "N is even" case above).
            // In either scenario, Bob wins. Thus, Alice loses.
            //
            // Therefore, if the initial XOR sum is not 0, Alice wins if and only if the number of elements is even.
            nums.len() % 2 == 0
        }
    }
}