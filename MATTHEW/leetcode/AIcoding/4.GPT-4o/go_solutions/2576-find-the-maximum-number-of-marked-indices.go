func maxNumOfMarkedIndices(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    marked := make([]bool, n)
    count := 0

    for i := 0; i < n/2; i++ {
        if marked[i] {
            continue
        }
        for j := n/2; j < n; j++ {
            if !marked[j] && nums[j] >= 2*nums[i] {
                marked[i] = true
                marked[j] = true
                count += 2
                break
            }
        }
    }

    return count
}