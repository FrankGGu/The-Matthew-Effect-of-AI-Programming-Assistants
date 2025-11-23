func winnerSquareGame(n int) bool {
    dp := make([]bool, n+1)

    // dp[0] is false: if there are 0 stones, the current player cannot make a move and loses.
    // dp[1] is true: if there is 1 stone, the current player takes 1*1=1 stone, leaves 0, and wins.
    // dp[2] is false: take 1*1=1 stone, leaves 1 stone. dp[1] is true, meaning the next player wins.
    //                 So, taking 1 stone leads to a loss for the current player. No other moves.
    // dp[3] is true: take 1*1=1 stone, leaves 2 stones. dp[2] is false, meaning the next player loses.
    //                So, taking 1 stone leads to a win for the current player.
    // dp[4] is true: take 2*2=4 stones, leaves 0 stones. dp[0] is false, meaning the next player loses.
    //                So, taking 4 stones leads to a win for the current player.

    for i := 1; i <= n; i++ {
        // Alice wins if she can make a move to a state where Bob loses.
        // i.e., there exists a k such that dp[i - k*k] is false.
        for k := 1; k*k <= i; k++ {
            if !dp[i-k*k] {
                dp[i] = true
                break // Alice found a winning move, no need to check further k's for this i.
            }
        }
    }

    return dp[n]
}