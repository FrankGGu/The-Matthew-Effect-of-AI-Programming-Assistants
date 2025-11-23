package main

type ProductOfNumbers struct {
    nums []int
}

func Constructor() ProductOfNumbers {
    return ProductOfNumbers{
        nums: make([]int, 0),
    }
}

func (this *ProductOfNumbers) Add(num int) {
    this.nums = append(this.nums, num)
}

func (this *ProductOfNumbers) GetProduct(k int) int {
    product := 1
    for i := len(this.nums) - k; i < len(this.nums); i++ {
        product *= this.nums[i]
    }
    return product
}