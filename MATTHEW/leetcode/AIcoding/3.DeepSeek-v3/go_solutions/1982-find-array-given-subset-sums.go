func recoverArray(n int, sums []int) []int {
    sort.Ints(sums)
    res := make([]int, 0, n)
    for len(sums) > 1 {
        x := sums[1] - sums[0]
        freq := make(map[int]int)
        for _, num := range sums {
            freq[num]++
        }
        s0, s1 := make([]int, 0), make([]int, 0)
        for _, num := range sums {
            if freq[num] > 0 {
                s0 = append(s0, num)
                freq[num]--
                s1 = append(s1, num+x)
                freq[num+x]--
            }
        }
        var next []int
        if contains(s0, 0) {
            next = s0
            res = append(res, x)
        } else {
            next = s1
            res = append(res, -x)
        }
        sums = next
    }
    return res
}

func contains(arr []int, target int) bool {
    for _, num := range arr {
        if num == target {
            return true
        }
    }
    return false
}