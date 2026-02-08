package main

func maxNumberWithPriceSum(k int) int {
    var find func(int) bool
    find = func(n int) bool {
        sum := 0
        for i := 1; i <= n; i++ {
            num := i
            for num > 0 {
                if num%10 == 1 {
                    sum++
                }
                num /= 10
            }
            if sum > k {
                return false
            }
        }
        return sum <= k
    }

    left, right := 1, 1<<30
    var ans int
    for left <= right {
        mid := left + (right-left)/2
        if find(mid) {
            ans = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return ans
}