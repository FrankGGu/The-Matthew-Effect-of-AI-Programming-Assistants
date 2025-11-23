func maxTotalFruits(fruits [][]int, startPos int, k int) int {
    maxPos := 0
    for _, fruit := range fruits {
        if fruit[0] > maxPos {
            maxPos = fruit[0]
        }
    }
    maxPos++

    prefix := make([]int, maxPos+1)
    for _, fruit := range fruits {
        pos, amount := fruit[0], fruit[1]
        prefix[pos+1] = amount
    }
    for i := 1; i <= maxPos; i++ {
        prefix[i] += prefix[i-1]
    }

    res := 0
    for left := 0; left <= k; left++ {
        right := k - 2*left
        if right < 0 {
            continue
        }
        l := startPos - left
        r := startPos + right
        if l < 0 {
            l = 0
        }
        if r >= maxPos {
            r = maxPos - 1
        }
        if l <= r {
            sum := prefix[r+1] - prefix[l]
            if sum > res {
                res = sum
            }
        }
    }

    for right := 0; right <= k; right++ {
        left := k - 2*right
        if left < 0 {
            continue
        }
        l := startPos - left
        r := startPos + right
        if l < 0 {
            l = 0
        }
        if r >= maxPos {
            r = maxPos - 1
        }
        if l <= r {
            sum := prefix[r+1] - prefix[l]
            if sum > res {
                res = sum
            }
        }
    }

    return res
}