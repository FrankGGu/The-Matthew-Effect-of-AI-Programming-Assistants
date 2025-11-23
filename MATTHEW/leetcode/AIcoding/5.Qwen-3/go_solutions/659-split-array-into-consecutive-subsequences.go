package main

func isPossible(nums []int) bool {
    from := make(map[int]int)
    to := make(map[int]int)
    for _, num := range nums {
        from[num]++
    }
    for num, count := range from {
        if count == 0 {
            continue
        }
        if to[num-1] > 0 {
            to[num-1]--
            to[num] += count
        } else {
            if from[num+1] > 0 && from[num+2] > 0 {
                from[num+1]--
                from[num+2]--
                to[num+2] += count
            } else {
                return false
            }
        }
    }
    return true
}