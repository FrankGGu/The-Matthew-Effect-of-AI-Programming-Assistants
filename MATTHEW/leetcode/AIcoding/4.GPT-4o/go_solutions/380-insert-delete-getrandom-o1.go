import "math/rand"

type RandomizedSet struct {
    nums map[int]int
    list []int
}

func Constructor() RandomizedSet {
    return RandomizedSet{
        nums: make(map[int]int),
        list: []int{},
    }
}

func (this *RandomizedSet) Insert(val int) bool {
    if _, exists := this.nums[val]; exists {
        return false
    }
    this.nums[val] = len(this.list)
    this.list = append(this.list, val)
    return true
}

func (this *RandomizedSet) Remove(val int) bool {
    if idx, exists := this.nums[val]; exists {
        last := this.list[len(this.list)-1]
        this.list[idx] = last
        this.nums[last] = idx
        this.list = this.list[:len(this.list)-1]
        delete(this.nums, val)
        return true
    }
    return false
}

func (this *RandomizedSet) GetRandom() int {
    return this.list[rand.Intn(len(this.list))]
}