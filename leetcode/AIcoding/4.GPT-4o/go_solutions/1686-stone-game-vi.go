func stoneGameVI(A []int, B []int) int {
    n := len(A)
    pairs := make([][2]int, n)

    for i := 0; i < n; i++ {
        pairs[i] = [2]int{A[i] + B[i], i}
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][0] > pairs[j][0]
    })

    scoreAlice, scoreBob := 0, 0

    for i := 0; i < n; i++ {
        if i%2 == 0 {
            scoreAlice += A[pairs[i][1]]
        } else {
            scoreBob += B[pairs[i][1]]
        }
    }

    if scoreAlice > scoreBob {
        return 1
    } else if scoreAlice < scoreBob {
        return -1
    }
    return 0
}