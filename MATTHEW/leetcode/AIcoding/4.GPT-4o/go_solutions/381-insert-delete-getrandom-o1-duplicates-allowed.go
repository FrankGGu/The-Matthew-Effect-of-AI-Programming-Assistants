type RandomizedCollection struct {
    nums   []int
    indices map[int]map[int]struct{}
    rand    *rand.Rand
}

func Constructor() RandomizedCollection {
    return RandomizedCollection{
        nums:   []int{},
        indices: make(map[int]map[int]struct{}),
        rand:   rand.New(rand.NewSource(time.Now().UnixNano())),
    }
}

func (this *RandomizedCollection) Insert(val int) bool {
    if _, exists := this.indices[val]; !exists {
        this.indices[val] = make(map[int]struct{})
    }
    this.indices[val][len(this.nums)] = struct{}{}
    this.nums = append(this.nums, val)
    return len(this.indices[val]) == 1
}

func (this *RandomizedCollection) Remove(val int) bool {
    if _, exists := this.indices[val]; !exists {
        return false
    }
    idxToRemove := -1
    for idx := range this.indices[val] {
        idxToRemove = idx
        break
    }
    lastVal := this.nums[len(this.nums)-1]
    this.nums[idxToRemove] = lastVal
    this.indices[lastVal][idxToRemove] = struct{}{}
    delete(this.indices[val], idxToRemove)

    if len(this.indices[val]) == 0 {
        delete(this.indices, val)
    }
    this.nums = this.nums[:len(this.nums)-1]
    return true
}

func (this *RandomizedCollection) GetRandom() int {
    return this.nums[this.rand.Intn(len(this.nums))]
}