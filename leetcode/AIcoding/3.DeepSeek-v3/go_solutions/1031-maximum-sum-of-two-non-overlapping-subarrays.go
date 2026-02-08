func maxSumTwoNoOverlap(nums []int, firstLen int, secondLen int) int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    maxFirst, maxSecond, res := 0, 0, 0

    for i := firstLen + secondLen; i <= n; i++ {
        maxFirst = max(maxFirst, prefix[i-secondLen] - prefix[i-secondLen-firstLen])
        res = max(res, maxFirst + prefix[i] - prefix[i-secondLen])
    }

    for i := firstLen + secondLen; i <= n; i++ {
        maxSecond = max(maxSecond, prefix[i-firstLen] - prefix[i-firstLen-secondLen])
        res = max(res, maxSecond + prefix[i] - prefix[i-firstLen])
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}