import "sort"

func canDivideIntoSets(nums []int, k int) bool {
    if len(nums)%k != 0 {
        return false
    }
    sort.Ints(nums)
    counts := make(map[int]int)
    for _, num := range nums {
        counts[num]++
    }

    for _, num := range nums {
        if counts[num] == 0 {
            continue
        }
        for i := 0; i < k; i++ {
            if counts[num+i] == 0 {
                return false
            }
            counts[num+i]--
        }
    }
    return true
}