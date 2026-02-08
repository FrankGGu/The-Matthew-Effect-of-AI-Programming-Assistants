func maxDistToClosest(seats []int) int {
    n := len(seats)
    left := make([]int, n)
    right := make([]int, n)

    last := -1
    for i := 0; i < n; i++ {
        if seats[i] == 1 {
            last = i
        }
        left[i] = -1
        if last != -1 {
            left[i] = i - last
        }
    }

    last = -1
    for i := n - 1; i >= 0; i-- {
        if seats[i] == 1 {
            last = i
        }
        right[i] = -1
        if last != -1 {
            right[i] = last - i
        }
    }

    ans := 0
    for i := 0; i < n; i++ {
        if seats[i] == 0 {
            l := left[i]
            r := right[i]
            dist := -1
            if l == -1 && r == -1 {
                continue
            } else if l == -1 {
                dist = r
            } else if r == -1 {
                dist = l
            } else {
                dist = min(l, r)
            }
            ans = max(ans, dist)
        }
    }
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}