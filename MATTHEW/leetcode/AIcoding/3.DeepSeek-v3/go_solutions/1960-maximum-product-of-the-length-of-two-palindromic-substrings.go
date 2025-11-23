func maxProduct(s string) int64 {
    n := len(s)
    maxLen := make([]int, n)
    maxRight, center := -1, -1
    for i := 0; i < n; i++ {
        var r int
        if i > maxRight {
            r = 1
            for i-r >= 0 && i+r < n && s[i-r] == s[i+r] {
                r++
            }
            maxLen[i] = r - 1
        } else {
            mirror := 2*center - i
            minLen := min(maxLen[mirror], maxRight-i)
            r = minLen + 1
            for i-r >= 0 && i+r < n && s[i-r] == s[i+r] {
                r++
            }
            maxLen[i] = r - 1
            if i+maxLen[i] > maxRight {
                maxRight = i + maxLen[i]
                center = i
            }
        }
    }

    leftMax := make([]int, n)
    maxL := 0
    for i := 0; i < n; i++ {
        l := i - maxLen[i]
        for maxL <= l {
            leftMax[maxL] = max(leftMax[maxL], 2*(i-maxL)-1)
            maxL++
        }
    }
    for i := 1; i < n; i++ {
        leftMax[i] = max(leftMax[i], leftMax[i-1])
    }

    rightMax := make([]int, n)
    maxR := n - 1
    for i := n - 1; i >= 0; i-- {
        r := i + maxLen[i]
        for maxR >= r {
            rightMax[maxR] = max(rightMax[maxR], 2*(maxR-i)+1)
            maxR--
        }
    }
    for i := n - 2; i >= 0; i-- {
        rightMax[i] = max(rightMax[i], rightMax[i+1])
    }

    res := 0
    for i := 0; i < n-1; i++ {
        res = max(res, leftMax[i]*rightMax[i+1])
    }
    return int64(res)
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