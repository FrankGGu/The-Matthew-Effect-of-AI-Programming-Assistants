func intersection(nums [][]int) []int {
    freq := make(map[int]int)
    for _, arr := range nums {
        for _, num := range arr {
            freq[num]++
        }
    }
    n := len(nums)
    var res []int
    for num, cnt := range freq {
        if cnt == n {
            res = append(res, num)
        }
    }
    sort.Ints(res)
    return res
}