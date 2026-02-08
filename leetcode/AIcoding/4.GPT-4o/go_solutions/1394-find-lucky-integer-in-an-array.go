func findLucky(arr []int) int {
    count := make(map[int]int)
    for _, num := range arr {
        count[num]++
    }
    lucky := -1
    for num, cnt := range count {
        if num == cnt && num > lucky {
            lucky = num
        }
    }
    return lucky
}