func magicalString(n int) int {
    if n == 0 {
        return 0
    }
    if n <= 3 {
        return 1
    }

    s := make([]int, n)
    s[0], s[1], s[2] = 1, 2, 2

    count := 1
    index := 2

    for i := 3; i < n; {
        for j := 0; j < s[index]; j++ {
            if i < n {
                s[i] = count
                i++
            }
        }
        count = 3 - count
        index++
    }

    totalOnes := 0
    for i := 0; i < n; i++ {
        if s[i] == 1 {
            totalOnes++
        }
    }

    return totalOnes
}