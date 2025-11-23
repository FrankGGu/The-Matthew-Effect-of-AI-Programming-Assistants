func findEvenNumbers(digits []int) []int {
    freq := make(map[int]int)
    for _, d := range digits {
        freq[d]++
    }

    var res []int
    for num := 100; num < 1000; num += 2 {
        a, b, c := num/100, (num/10)%10, num%10
        tempFreq := make(map[int]int)
        tempFreq[a]++
        tempFreq[b]++
        tempFreq[c]++

        valid := true
        for k, v := range tempFreq {
            if freq[k] < v {
                valid = false
                break
            }
        }
        if valid {
            res = append(res, num)
        }
    }
    return res
}