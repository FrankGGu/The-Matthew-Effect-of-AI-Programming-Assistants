type RangeFreqQuery struct {
    arr []int
    indices map[int][]int
}

func Constructor(arr []int) RangeFreqQuery {
    indices := make(map[int][]int)
    for i, num := range arr {
        indices[num] = append(indices[num], i)
    }
    return RangeFreqQuery{
        arr: arr,
        indices: indices,
    }
}

func (this *RangeFreqQuery) Query(left int, right int, value int) int {
    count := 0
    if _, ok := this.indices[value]; !ok {
        return 0
    }

    leftIndices := this.indices[value]

    l := 0
    r := len(leftIndices) - 1
    start := -1
    for l <= r {
        mid := l + (r - l) / 2
        if leftIndices[mid] >= left {
            start = leftIndices[mid]
            r = mid - 1
        } else {
            l = mid + 1
        }
    }

    l = 0
    r = len(leftIndices) - 1
    end := -1
    for l <= r {
        mid := l + (r - l) / 2
        if leftIndices[mid] <= right {
            end = leftIndices[mid]
            l = mid + 1
        } else {
            r = mid - 1
        }
    }

    if start == -1 || end == -1 {
        return 0
    }

    startIdx := -1
    endIdx := -1

    l = 0
    r = len(leftIndices) - 1
    for l <= r {
        mid := l + (r - l) / 2
        if leftIndices[mid] >= left {
            startIdx = mid
            r = mid - 1
        } else {
            l = mid + 1
        }
    }

    l = 0
    r = len(leftIndices) - 1
    for l <= r {
        mid := l + (r - l) / 2
        if leftIndices[mid] <= right {
            endIdx = mid
            l = mid + 1
        } else {
            r = mid - 1
        }
    }

    if startIdx == -1 || endIdx == -1{
        return 0
    }

    return endIdx - startIdx + 1
}