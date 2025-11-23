func minimalKSum(nums []int, k int) int64 {
    sort.Ints(nums)
    res := 0
    prev := 0
    for _, num := range nums {
        if num == prev {
            continue
        }
        if num > prev+1 {
            cnt := num - prev - 1
            if cnt > k {
                cnt = k
            }
            res += (prev + 1 + prev + cnt) * cnt / 2
            k -= cnt
            if k == 0 {
                break
            }
        }
        prev = num
    }
    if k > 0 {
        res += (prev + 1 + prev + k) * k / 2
    }
    return int64(res)
}