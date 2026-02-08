package main

func numberOfPairs(nums []string, target string) int {
    count := 0
    m := make(map[string]int)
    for _, num := range nums {
        m[num]++
    }
    for _, num := range nums {
        if len(num) > len(target) {
            continue
        }
        remaining := target[len(num):]
        if val, ok := m[remaining]; ok {
            if num != remaining {
                count += val
            } else {
                count += val - 1
            }
        }
    }
    return count
}