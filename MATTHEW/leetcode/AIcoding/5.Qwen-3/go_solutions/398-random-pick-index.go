package main

type Solution struct {
    nums []int
}

func Constructor(nums []int) Solution {
    return Solution{nums: nums}
}

func (this *Solution) PickIndex() int {
    rand.Seed(time.Now().UnixNano())
    var index int
    count := 0
    for i, num := range this.nums {
        if num == this.nums[0] {
            count++
            if rand.Intn(count) == 0 {
                index = i
            }
        }
    }
    return index
}