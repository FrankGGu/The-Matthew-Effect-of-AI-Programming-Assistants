type ProductOfNumbers struct {
    nums []int
}

func Constructor() ProductOfNumbers {
    return ProductOfNumbers{nums: []int{1}}
}

func (this *ProductOfNumbers) Add(num int) {
    if num == 0 {
        this.nums = append(this.nums, 1)
    } else {
        this.nums = append(this.nums, this.nums[len(this.nums)-1]*num)
    }
}

func (this *ProductOfNumbers) GetProduct(k int) int {
    if k >= len(this.nums) {
        return 0
    }
    return this.nums[len(this.nums)-1] / this.nums[len(this.nums)-1-k]
}