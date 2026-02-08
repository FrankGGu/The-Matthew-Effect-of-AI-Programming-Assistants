package main

func distributeCookies(cookies []int, k int) int {
    var result = math.MaxInt32
    var distribution = make([]int, k)

    var backtrack func(int)
    backtrack = func(index int) {
        if index == len(cookies) {
            max := 0
            for _, v := range distribution {
                if v > max {
                    max = v
                }
            }
            if max < result {
                result = max
            }
            return
        }

        for i := 0; i < k; i++ {
            if i > 0 && distribution[i] == distribution[i-1] {
                continue
            }
            if distribution[i]+cookies[index] >= result {
                continue
            }
            distribution[i] += cookies[index]
            backtrack(index + 1)
            distribution[i] -= cookies[index]
        }
    }

    sort.Ints(cookies)
    backtrack(0)
    return result
}