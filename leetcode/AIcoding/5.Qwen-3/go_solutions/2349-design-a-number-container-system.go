package main

type NumberContainer struct {
    indexMap map[int]int
    valueMap map[int][]int
}

func Constructor() NumberContainer {
    return NumberContainer{
        indexMap: make(map[int]int),
        valueMap: make(map[int][]int),
    }
}

func (this *NumberContainer) Change(index int, number int) {
    if val, exists := this.indexMap[index]; exists {
        // Remove the index from the old value's list
        for i, v := range this.valueMap[val] {
            if v == index {
                this.valueMap[val] = append(this.valueMap[val][:i], this.valueMap[val][i+1:]...)
                break
            }
        }
    }
    this.indexMap[index] = number
    this.valueMap[number] = append(this.valueMap[number], index)
}

func (this *NumberContainer) Find(index int) int {
    return this.indexMap[index]
}

func (this *NumberContainer) GetMin() int {
    minVal := -1
    for key := range this.valueMap {
        if minVal == -1 || key < minVal {
            minVal = key
        }
    }
    return minVal
}