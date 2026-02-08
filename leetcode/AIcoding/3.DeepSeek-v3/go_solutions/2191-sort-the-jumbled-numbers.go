func sortJumbled(mapping []int, nums []int) []int {
    type pair struct {
        original int
        mapped   int
    }
    pairs := make([]pair, len(nums))
    for i, num := range nums {
        mapped := 0
        if num == 0 {
            mapped = mapping[0]
        } else {
            temp := num
            base := 1
            for temp > 0 {
                digit := temp % 10
                mapped += mapping[digit] * base
                temp /= 10
                base *= 10
            }
        }
        pairs[i] = pair{original: num, mapped: mapped}
    }
    sort.Slice(pairs, func(i, j int) bool {
        if pairs[i].mapped == pairs[j].mapped {
            return i < j
        }
        return pairs[i].mapped < pairs[j].mapped
    })
    res := make([]int, len(nums))
    for i := range res {
        res[i] = pairs[i].original
    }
    return res
}