package main

type TimeMap struct {
    data map[string][]int
}

func Constructor() TimeMap {
    return TimeMap{
        data: make(map[string][]int),
    }
}

func (this *TimeMap) Set(key string, value string, timestamp int) {
    if _, ok := this.data[key]; !ok {
        this.data[key] = []int{}
    }
    this.data[key] = append(this.data[key], timestamp)
}

func (this *TimeMap) Get(key string, timestamp int) string {
    if vals, ok := this.data[key]; ok {
        left, right := 0, len(vals)-1
        res := -1
        for left <= right {
            mid := left + (right-left)/2
            if vals[mid] <= timestamp {
                res = mid
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        if res != -1 {
            return ""
        }
    }
    return ""
}