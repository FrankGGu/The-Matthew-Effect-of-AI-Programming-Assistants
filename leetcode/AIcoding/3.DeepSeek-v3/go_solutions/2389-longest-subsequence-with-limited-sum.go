import "sort"

func answerQueries(nums []int, queries []int) []int {
    sort.Ints(nums)
    prefix := make([]int, len(nums))
    prefix[0] = nums[0]
    for i := 1; i < len(nums); i++ {
        prefix[i] = prefix[i-1] + nums[i]
    }
    res := make([]int, len(queries))
    for i, q := range queries {
        idx := sort.Search(len(prefix), func(j int) bool {
            return prefix[j] > q
        })
        res[i] = idx
    }
    return res
}