type Fancy struct {
    nums []int
    add  []int
    mul  []int
}

func Constructor() Fancy {
    return Fancy{
        nums: []int{},
        add:  []int{},
        mul:  []int{},
    }
}

func (this *Fancy) Append(a int) {
    this.nums = append(this.nums, a)
    this.add = append(this.add, 0)
    this.mul = append(this.mul, 1)
}

func (this *Fancy) AddAll(a int) {
    for i := range this.add {
        this.add[i] += a
    }
}

func (this *Fancy) MultAll(m int) {
    for i := range this.nums {
        this.nums[i] = (this.nums[i] * m) % 1000000007
    }
    for i := range this.add {
        this.add[i] = (this.add[i] * m) % 1000000007
    }
}

func (this *Fancy) GetIndex(i int) int {
    if i < 0 || i >= len(this.nums) {
        return -1
    }
    return (this.nums[i] + this.add[i]) % 1000000007
}