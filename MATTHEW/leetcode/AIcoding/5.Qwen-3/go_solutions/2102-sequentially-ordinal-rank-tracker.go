package main

type SORTracker struct {
    data []string
    index int
}

func Constructor() SORTracker {
    return SORTracker{
        data:  make([]string, 0),
        index: 0,
    }
}

func (this *SORTracker) Add(name string, score int) {
    this.data = append(this.data, name)
}

func (this *SORTracker) Get() string {
    return this.data[this.index]
}