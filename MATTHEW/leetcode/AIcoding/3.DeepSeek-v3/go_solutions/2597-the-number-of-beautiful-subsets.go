func beautifulSubsets(nums []int, k int) int {
    count := 0
    freq := make(map[int]int)
    var backtrack func(int)
    backtrack = func(index int) {
        if index == len(nums) {
            count++
            return
        }
        num := nums[index]
        if freq[num-k] == 0 && freq[num+k] == 0 {
            freq[num]++
            backtrack(index + 1)
            freq[num]--
        }
        backtrack(index + 1)
    }
    backtrack(0)
    return count - 1
}