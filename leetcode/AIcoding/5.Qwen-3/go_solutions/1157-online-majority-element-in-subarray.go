package main

type MajorityChecker struct {
    nums []int
    indexMap map[int][]int
}

func Constructor(nums []int) MajorityChecker {
    m := make(map[int][]int)
    for i, num := range nums {
        m[num] = append(m[num], i)
    }
    return MajorityChecker{
        nums: nums,
        indexMap: m,
    }
}

func (this *MajorityChecker) Query(left int, right int, threshold int) int {
    nums := this.nums
    indexMap := this.indexMap
    candidates := []int{}
    for k := range indexMap {
        candidates = append(candidates, k)
    }
    for _, candidate := range candidates {
        indices := indexMap[candidate]
        l := 0
        r := len(indices) - 1
        for l <= r {
            mid := (l + r) / 2
            if indices[mid] < left {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        start := l
        l = 0
        r = len(indices) - 1
        for l <= r {
            mid := (l + r) / 2
            if indices[mid] > right {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        end := r
        if end-start+1 >= threshold {
            return candidate
        }
    }
    return -1
}