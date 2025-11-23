func maxSum(nums []int) int {
    digitSum := func(n int) int {
        sum := 0
        for n > 0 {
            sum += n % 10
            n /= 10
        }
        return sum
    }

    maxSum := -1
    sums := make(map[int][]int)

    for _, num := range nums {
        s := digitSum(num)
        sums[s] = append(sums[s], num)
    }

    for _, nums := range sums {
        if len(nums) >= 2 {
            max1, max2 := -1, -1
            for _, num := range nums {
                if num > max1 {
                    max2 = max1
                    max1 = num
                } else if num > max2 {
                    max2 = num
                }
            }
            if max1 != -1 && max2 != -1 {
                if max1+max2 > maxSum {
                    maxSum = max1 + max2
                }
            }
        }
    }

    return maxSum
}