type TimeMap struct {
    store map[string][]entry
}

type entry struct {
    timestamp int
    value     string
}

func Constructor() TimeMap {
    return TimeMap{
        store: make(map[string][]entry),
    }
}

func (this *TimeMap) Set(key string, value string, timestamp int) {
    this.store[key] = append(this.store[key], entry{timestamp: timestamp, value: value})
}

func (this *TimeMap) Get(key string, timestamp int) string {
    entries, ok := this.store[key]
    if !ok {
        return ""
    }

    l, r := 0, len(entries)-1
    res := ""

    for l <= r {
        mid := l + (r-l)/2
        if entries[mid].timestamp <= timestamp {
            res = entries[mid].value
            l = mid + 1
        } else {
            r = mid - 1
        }
    }

    return res
}