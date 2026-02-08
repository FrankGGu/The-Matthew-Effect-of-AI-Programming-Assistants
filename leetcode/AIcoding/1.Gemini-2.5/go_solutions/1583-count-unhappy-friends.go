func unhappyFriends(n int, preferences [][]int, pairs [][]int) int {
    // rank[i][j] stores the preference rank of friend j for friend i.
    // A smaller rank means higher preference.
    rank := make([][]int, n)
    for i := 0; i < n; i++ {
        rank