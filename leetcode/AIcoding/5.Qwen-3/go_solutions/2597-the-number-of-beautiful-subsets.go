package main

func beautifulSubsets(nums []int, k int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    var dfs func(int, int) int
    dfs = func(index int, prev int) int {
        if index == len(nums) {
            return 0
        }
        res := 0
        num := nums[index]
        if count[num] > 0 {
            if prev != num-k {
                count[num]--
                res += 1 + dfs(index+1, num)
                count[num]++
            }
        }
        res += dfs(index+1, prev)
        return res
    }

    return dfs(0, -k-1)
}