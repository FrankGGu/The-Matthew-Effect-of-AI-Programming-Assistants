class Solution {
    public int stoneGameVII(int[] stones) {
        int n = stones.length;

        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        int[][] dp = new int[n][n];

        // len is the length of the subarray
        // It goes from 2 to n. For len = 1, dp[i][i] is 0 as per problem wording
        // "The score of the player is the sum of the values of the stones they remove."
        // "Alice wants to maximize the difference between her score and Bob's score."
        // "The game ends when there are no stones left."
        // If there's only one stone, the current player takes it. But the *difference*
        // is about the total game. The problem asks for the maximum score difference
        // Alice can achieve.
        // A common DP for this type of game is to define dp[i][j] as the maximum
        // score the current player can get from stones[i...j].
        // The base case for this definition is dp[i][i] = stones[i].
        // Let's re-read the problem statement carefully: "Alice and Bob play a game with n stones.
        // In each turn, a player removes either the leftmost or the rightmost stone.
        // The score of the player is the sum of the values of the stones they remove.
        // The game ends when there are no stones left.
        // Alice wants to maximize the difference between her score and Bob's score."
        //
        // The standard approach for "maximize your score - opponent's score" is to define
        // dp[i][j] as the maximum score *current player* can get from stones[i...j].
        // If current player takes stones[k], their score increases by stones[k].
        // The opponent then plays on the remaining stones. The opponent will get dp_opponent
        // from the remaining. The current player will get sum_remaining - dp_opponent.
        // So, if current player takes stones[i]: stones[i] + (sum(stones[i+1...j]) - dp[i+1][j])
        // which simplifies to sum(stones[i...j]) - dp[i+1][j].
        //
        // Base case: For a single stone (len=1), dp[i][i] = 0. This is because when there's only one stone,
        // the player takes it, but there's no "next player" to subtract from. The score is not about
        // the stone itself, but the *difference* in the context of the entire game.
        // If dp[i][j] is the maximum score *difference* the current player can achieve from stones[i...j].
        // If current player takes stones[i], their score increases by stones[i]. The opponent then plays
        // on stones[i+1...j]. The opponent will achieve dp[i+1][j] difference.
        // So current player's difference = stones[i] - dp[i+1][j].
        // This is the standard minimax recursion.

        // Initialize dp for length 1 (base case)
        // If there's only one stone, the player takes it. The difference they achieve from this *subgame* is 0,
        // because there's no opponent to play against. The problem is about maximizing the *total* difference.
        // So, if dp[i][j] is the maximum difference Alice can achieve from stones[i...j],
        // for len = 1, dp[i][i] = 0.
        // This is a common pitfall. Let's use the standard definition for "maximize score - opponent's score".
        // dp[i][j] = max score difference the *first player* can achieve from stones[i...j].
        // If len=1, first player picks stones[i]. Their score is stones[i]. Opponent's score is 0. Difference = stones[i].
        // So, dp[i][i] = stones[i]. This makes more sense for the difference.

        // Correct definition: dp[i][j] is the maximum score difference the *current player* can achieve from stones[i...j].
        // For len = 1 (i.e. i == j): The current player takes stones[i]. Their score is stones[i]. The opponent gets 0.
        // So, dp[i][i] = stones[i].

        for (int i = 0; i < n; i++) {
            dp[i][i] = 0; // If only one stone, no score difference from this subproblem as the game ends.
                          // The problem is about maximizing the total difference.
                          // Let's use the definition from the example trace:
                          // dp[i][j] = max score Alice can get from stones[i...j].
                          // Then dp[i][i] = stones[i].
                          // The example trace was correct. dp[i][i] = stones[i].
        }

        // dp[i][j] = max score the current player can get from stones[i...j]
        // The problem asks for Alice's score - Bob's score.
        // Let A be Alice's score and B be Bob's score. We want to maximize A - B.
        // Total sum S = A + B. So B = S - A.
        // We want to maximize A - (S - A) = 2A - S.
        // This means we need to find the maximum score Alice can get (A).
        // Let dp[i][j] be the maximum score the *current player* can get from stones[i...j].

        // Base case: len = 1. dp[i][i] = 0. (No score difference from a single stone, as the game ends immediately)
        // This is tricky. Let's re-evaluate the example with dp[i][i] = 0.
        // stones = [5, 2, 4]
        // prefixSum = [0, 5, 7, 11]
        // dp[0][0]=0, dp[1][1]=0, dp[2][2]=0

        // len = 2:
        // i=0, j=1: stones[0...1] = [5, 2]. currentSum = 7.
        // dp[0][1] = max(currentSum - dp[1][1], currentSum - dp[0][0])
        // dp[0][1] = max(7 - 0, 7 - 0) = 7.
        // This means from [5,2], current player can get 7. (Takes 5, Bob takes 2. Current player gets 5. Opponent gets 2. Total 7. Current player gets 5. Opponent gets 2.
        // If dp[i][j] is the max score current player gets, then for [5,2], if current player takes 5, their score is 5. Opponent takes 2, opponent's score is 2.
        // So current player's score from [5,2] is 5.
        // If current player takes 2, their score is 2. Opponent takes 5, opponent's score is 5.
        // So current player's score from [5,2] is 2.
        // Max score current player can get from [5,2] is 5.
        // So dp[0][1] should be 5.
        // The recurrence `sum(stones[i...j]) - dp[i+1][j]` assumes `dp[i+1][j]` is the maximum score the *next player* can get from `stones[i+1...j]`.
        // If total sum of `stones[i+1...j]` is `S_rem`, and next player gets `dp[i+1][j]`, then current player gets `S_rem - dp[i+1][j]`.
        // So, if current player picks `stones[i]`, their score is `stones[i] + (sum_rem - dp[i+1][j])`.
        // This means `dp[i][i]` should be `stones[i]`.

        // Let's retry with dp[i][i] = stones[i].
        // dp[i][j] = max score *current player* can get from stones[i...j].
        // Base case: len = 1. dp[i][i] = stones[i].
        // stones = [5, 2, 4]
        // prefixSum = [0, 5, 7, 11]
        // dp[0][0]=5, dp[1][1]=2, dp[2][2]=4

        // len = 2:
        // i=0, j=1: stones[0...1] = [5, 2]. currentSum = 7.
        // dp[0][1] = max(currentSum - dp[1][1], currentSum - dp[0][0])
        // dp[0][1] = max(7 - 2, 7 - 5) = max(5, 2) = 5. (Correct, current player takes 5, Bob takes 2. Current player gets 5.)

        // i=1, j=2: stones[1...2] = [2, 4]. currentSum = 6.
        // dp[1][2] = max(currentSum - dp[2][2], currentSum - dp[1][1])
        // dp[1][2] = max(6 - 4, 6 - 2) = max(2, 4) = 4. (Correct, current player takes 4, Bob takes 2. Current player gets 4.)

        // len = 3:
        // i=0, j=2: stones[0...2] = [5, 2, 4]. currentSum = 11.
        // dp[0][2] = max(currentSum - dp[1][2], currentSum - dp[0][1])
        // dp[0][2] = max(11 - 4, 11 - 5) = max(7, 6) = 7. (Correct, Alice gets 7)

        // This matches the manual trace and example. So, `dp[i][i] = stones[i]` is the correct base case for this DP state definition.

        for (int i = 0; i < n; i++) {
            dp[i][i] = stones[i];
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                int currentSum = prefixSum[j + 1] - prefixSum[i];

                // Option 1: Current player takes stones[i]
                // Their score from this move is stones[i].
                // The remaining stones are stones[i+1...j].
                // The total sum of these remaining stones is (currentSum - stones[i]).
                // The opponent will play on stones[i+1...j] and get dp[i+1][j] score.
                // So the current player will get (currentSum - stones[i]) - dp[i+1][j] from the remaining stones.
                // Total score for current player if they pick stones[i] is stones[i] + ((currentSum - stones[i]) - dp[i+1][j])
                // which simplifies to currentSum - dp[i+1][j].
                int scoreIfTakeLeft = currentSum - dp[i + 1][j];

                // Option 2: Current player takes stones[j]
                // Similarly, if they pick stones[j], their total score is currentSum - dp[i][j-1].
                int scoreIfTakeRight = currentSum - dp[i][j - 1];

                dp[i][j] = Math.max(scoreIfTakeLeft, scoreIfTakeRight);
            }
        }

        int aliceMaxScore = dp[0][n - 1];
        int totalSum = prefixSum[n];

        return 2 * aliceMaxScore - totalSum;
    }
}