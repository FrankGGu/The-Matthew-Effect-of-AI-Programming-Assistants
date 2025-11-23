func maximumGoodSubarraySum(nums []int, k int) int64 {
    seen := make(map[int]int)
    var ans int64 = -1000000000000000000
    var sum int64 = 0
    for _, num := range nums {
        sum += int64(num)
        if val, ok := seen[num]; ok {
            if val > 0 {
                if sum - int64(num) >= 0 {
                    if int64(num) + int64(k) <= 100000 {
                        if _, ok := seen[num+k]; ok {
                            if sum - int64(num) + int64(num+k) > int64(num+k) {
                                ans = max(ans, sum - int64(num) + int64(num+k))
                            } else {
                                ans = max(ans, int64(num+k))
                            }
                        }
                    }
                    if int64(num) - int64(k) >= -100000 {
                        if _, ok := seen[num-k]; ok {
                            if sum - int64(num) + int64(num-k) > int64(num-k){
                                ans = max(ans, sum - int64(num) + int64(num-k))
                            } else {
                                ans = max(ans, int64(num-k))
                            }
                        }
                    }
                    ans = max(ans, sum - int64(num))
                }

            }
        }
        if int64(num) + int64(k) <= 100000 {
            if _, ok := seen[num+k]; ok {
                 if int64(num+k) > int64(num) {
                    ans = max(ans, int64(num+k))
                 } else {
                    ans = max(ans, int64(num))
                 }
            }
        }
        if int64(num) - int64(k) >= -100000 {
            if _, ok := seen[num-k]; ok {
                if int64(num-k) > int64(num) {
                   ans = max(ans, int64(num-k))
                } else {
                   ans = max(ans, int64(num))
                }
            }
        }

        if _, ok := seen[num]; !ok {
            seen[num] = 1
        } else {
            seen[num]++
        }
        ans = max(ans, sum)
    }
    return ans
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}