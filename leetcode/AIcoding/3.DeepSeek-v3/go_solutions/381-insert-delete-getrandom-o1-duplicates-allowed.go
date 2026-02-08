import "math/rand"

type RandomizedCollection struct {
    nums []int
    idxs map[int]map[int]bool
}

func Constructor() RandomizedCollection {
    return RandomizedCollection{
        nums: make([]int, 0),
        idxs: make(map[int]map[int]bool),
    }
}

func (this *RandomizedCollection) Insert(val int) bool {
    _, exists := this.idxs[val]
    if !exists {
        this.idxs[val] = make(map[int]bool)
    }
    this.idxs[val][len(this.nums)] = true
    this.nums = append(this.nums, val)
    return !exists
}

func (this *RandomizedCollection) Remove(val int) bool {
    if _, exists := this.idxs[val]; !exists {
        return false
    }
    var pos int
    for p := range this.idxs[val] {
        pos = p
        break
    }
    delete(this.idxs[val], pos)
    if len(this.idxs[val]) == 0 {
        delete(this.idxs, val)
    }
    last := len(this.nums) - 1
    if pos != last {
        lastVal := this.nums[last]
        this.nums[pos] = lastVal
        delete(this.idxs[lastVal], last)
        this.idxs[lastVal][pos] = true
    }
    this.nums = this.nums[:last]
    return true
}

func (this *RandomizedCollection) GetRandom() int {
    return this.nums[rand.Intn(len(this.nums))]
}