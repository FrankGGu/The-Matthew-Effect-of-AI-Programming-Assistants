type Solution struct {
    original []int
    shuffled  []int
}

func Constructor(nums []int) Solution {
    return Solution{original: nums, shuffled: append([]int{}, nums...)}
}

func (this *Solution) Reset() []int {
    this.shuffled = append([]int{}, this.original...)
    return this.shuffled
}

func (this *Solution) Shuffle() []int {
    for i := len(this.shuffled) - 1; i > 0; i-- {
        j := rand.Intn(i + 1)
        this.shuffled[i], this.shuffled[j] = this.shuffled[j], this.shuffled[i]
    }
    return this.shuffled
}