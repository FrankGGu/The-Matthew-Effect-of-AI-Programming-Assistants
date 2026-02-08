import "math/rand"

type Solution struct {
    original []int
}

func Constructor(nums []int) Solution {
    return Solution{original: nums}
}

func (this *Solution) Reset() []int {
    return this.original
}

func (this *Solution) Shuffle() []int {
    shuffled := make([]int, len(this.original))
    copy(shuffled, this.original)
    for i := len(shuffled) - 1; i > 0; i-- {
        j := rand.Intn(i + 1)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    }
    return shuffled
}