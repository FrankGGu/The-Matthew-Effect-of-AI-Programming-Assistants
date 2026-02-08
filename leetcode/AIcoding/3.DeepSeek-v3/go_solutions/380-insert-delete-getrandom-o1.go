import "math/rand"

type RandomizedSet struct {
    dataMap map[int]int
    dataSlice []int
}

func Constructor() RandomizedSet {
    return RandomizedSet{
        dataMap: make(map[int]int),
        dataSlice: make([]int, 0),
    }
}

func (this *RandomizedSet) Insert(val int) bool {
    if _, exists := this.dataMap[val]; exists {
        return false
    }
    this.dataMap[val] = len(this.dataSlice)
    this.dataSlice = append(this.dataSlice, val)
    return true
}

func (this *RandomizedSet) Remove(val int) bool {
    index, exists := this.dataMap[val]
    if !exists {
        return false
    }
    last := this.dataSlice[len(this.dataSlice)-1]
    this.dataSlice[index] = last
    this.dataMap[last] = index
    this.dataSlice = this.dataSlice[:len(this.dataSlice)-1]
    delete(this.dataMap, val)
    return true
}

func (this *RandomizedSet) GetRandom() int {
    return this.dataSlice[rand.Intn(len(this.dataSlice))]
}