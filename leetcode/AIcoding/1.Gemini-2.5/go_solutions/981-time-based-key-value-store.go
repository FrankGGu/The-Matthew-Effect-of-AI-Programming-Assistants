package main

type entry struct {
	value     string
	timestamp int
}

type TimeMap struct {
	store map[string][]entry
}

func Constructor() TimeMap {
	return TimeMap{
		store: make(map[string][]entry),
	}
}

func (this *TimeMap) Set(key string, value string, timestamp int) {
	this.store[key] = append(this.store[key], entry{value: value, timestamp: timestamp})
}

func (this *TimeMap) Get(key string, timestamp int) string {
	entries, ok := this.store[key]
	if !ok {
		return ""
	}

	low := 0
	high := len(entries) - 1
	resultValue := ""

	for low <= high {
		mid := low + (high-low)/2
		if entries[mid].timestamp <= timestamp {
			resultValue = entries[mid].value
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return resultValue
}