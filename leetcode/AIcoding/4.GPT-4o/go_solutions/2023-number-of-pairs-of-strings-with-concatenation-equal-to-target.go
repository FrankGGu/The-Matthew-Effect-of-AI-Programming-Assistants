func numOfPairs(nums []string, target string) int {
    count := 0
    m := make(map[string]int)

    for _, num := range nums {
        m[num]++
    }

    for _, num := range nums {
        if len(target) >= len(num) && target[:len(num)] == num {
            suffix := target[len(num):]
            count += m[suffix]
            if suffix == num {
                count--
            }
        }
    }

    return count
}