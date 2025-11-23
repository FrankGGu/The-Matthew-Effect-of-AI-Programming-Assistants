type TimeMap struct {
    store map[string][]Pair
}

type Pair struct {
    value     string
    timestamp int
}

func Constructor() TimeMap {
    return TimeMap{store: make(map[string][]Pair)}
}

func (this *TimeMap) Set(key string, value string, timestamp int) {
    this.store[key] = append(this.store[key], Pair{value, timestamp})
}

func (this *TimeMap) Get(key string, timestamp int) string {
    pairs := this.store[key]
    left, right := 0, len(pairs)-1
    res := ""
    for left <= right {
        mid := left + (right-left)/2
        if pairs[mid].timestamp <= timestamp {
            res = pairs[mid].value
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return res
}