package main

func unhappyFriends(n int, preferences [][]int, pairs [][]int) int {
    // Create a map to store each person's preference rank
    rank := make([]map[int]int, n)
    for i := 0; i < n; i++ {
        rank[i] = make(map[int]int)
        for j, p := range preferences[i] {
            rank[i][p] = j
        }
    }

    // Create a map to store the partner of each person
    partner := make(map[int]int)
    for _, pair := range pairs {
        a, b := pair[0], pair[1]
        partner[a] = b
        partner[b] = a
    }

    // Check if a person is unhappy
    isUnhappy := func(a int) bool {
        b := partner[a]
        for _, p := range preferences[a] {
            if p == b {
                break
            }
            // Check if p is better than current partner
            if rank[p][a] < rank[p][partner[p]] {
                return true
            }
        }
        return false
    }

    // Count all unhappy friends
    count := 0
    for i := 0; i < n; i++ {
        if isUnhappy(i) {
            count++
        }
    }
    return count
}