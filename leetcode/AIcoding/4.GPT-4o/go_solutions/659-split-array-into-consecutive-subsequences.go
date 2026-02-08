import "sort"

func isPossible(nums []int) bool {
    count := make(map[int]int)
    tails := make(map[int]int)

    for _, num := range nums {
        count[num]++
    }

    for _, num := range nums {
        if count[num] == 0 {
            continue
        }
        count[num]--

        if tails[num-1] > 0 {
            tails[num-1]--
            tails[num]++
        } else if count[num+1] > 0 && count[num+2] > 0 {
            count[num+1]--
            count[num+2]--
            tails[num+2]++
        } else {
            return false
        }
    }
    return true
}