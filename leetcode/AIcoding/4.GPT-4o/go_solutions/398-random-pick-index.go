import "math/rand"

type Solution struct {
    nums []int
}

func Constructor(nums []int) Solution {
    return Solution{nums: nums}
}

func (this *Solution) Pick(target int) int {
    count := 0
    result := -1
    for i, num := range this.nums {
        if num == target {
            count++
            if rand.Intn(count) == 0 {
                result = i
            }
        }
    }
    return result
}