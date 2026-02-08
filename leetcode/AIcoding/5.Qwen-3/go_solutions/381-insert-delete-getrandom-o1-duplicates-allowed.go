package main

type RandomizedCollection struct {
    nums    []int
    indexMap map[int][]int
}

func Constructor() RandomizedCollection {
    return RandomizedCollection{
        nums:     make([]int, 0),
        indexMap: make(map[int][]int),
    }
}

func (this *RandomizedCollection) Insert(val int) bool {
    indexes, ok := this.indexMap[val]
    if !ok {
        indexes = make([]int, 0)
    }
    indexes = append(indexes, len(this.nums))
    this.indexMap[val] = indexes
    this.nums = append(this.nums, val)
    return len(indexes) == 1
}

func (this *RandomizedCollection) Remove(val int) bool {
    indexes, ok := this.indexMap[val]
    if !ok || len(indexes) == 0 {
        return false
    }
    lastIdx := len(this.nums) - 1
    lastVal := this.nums[lastIdx]
    idx := indexes[len(indexes)-1]
    this.nums[idx] = lastVal
    this.indexMap[lastVal][len(this.indexMap[lastVal])-1] = idx
    indexes = indexes[:len(indexes)-1]
    if len(indexes) == 0 {
        delete(this.indexMap, val)
    } else {
        this.indexMap[val] = indexes
    }
    this.nums = this.nums[:lastIdx]
    return true
}

func (this *RandomizedCollection) GetRandom() int {
    return this.nums[rand.Intn(len(this.nums))]
}