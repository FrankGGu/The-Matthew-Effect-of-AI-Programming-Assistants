package main

func kthSmallest(n int, k int) int {
    var count func(int, int) int
    count = func(n, curr int) int {
        steps := 0
        for curr <= n {
            steps += min(n - curr + 1, 10)
            curr *= 10
        }
        return steps
    }

    curr := 1
    for k > 1 {
        steps := count(n, curr)
        if k > steps {
            k -= steps
            curr++
        } else {
            k--
            curr *= 10
        }
    }
    return curr
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}