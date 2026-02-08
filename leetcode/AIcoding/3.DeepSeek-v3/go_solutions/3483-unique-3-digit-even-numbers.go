func findEvenNumbers(digits []int) []int {
    freq := make(map[int]int)
    for _, d := range digits {
        freq[d]++
    }

    var res []int
    for num := 100; num < 1000; num += 2 {
        a, b, c := num/100, (num/10)%10, num%10
        temp := make(map[int]int)
        temp[a]++
        temp[b]++
        temp[c]++

        valid := true
        for k, v := range temp {
            if freq[k] < v {
                valid = false
                break
            }
        }
        if valid {
            res = append(res, num)
        }
    }
    sort.Ints(res)
    return res
}