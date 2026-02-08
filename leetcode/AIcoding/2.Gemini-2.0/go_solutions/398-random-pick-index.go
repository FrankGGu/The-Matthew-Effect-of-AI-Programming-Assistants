import "math/rand"

type Solution struct {
    nums []int
}

func Constructor(nums []int) Solution {
    return Solution{nums: nums}
}

func (this *Solution) Pick(target int) int {
    indices := []int{}
    for i, num := range this.nums {
        if num == target {
            indices = append(indices, i)
        }
    }
    return indices[rand.Intn(len(indices))]
}