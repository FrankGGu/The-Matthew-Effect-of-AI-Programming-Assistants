package main

type SnapshotArray struct {
    data     map[int]int
    snapshots []map[int]int
    current  int
}

func Constructor(length int) SnapshotArray {
    return SnapshotArray{
        data:      make(map[int]int),
        snapshots: make([]map[int]int, 1),
        current:   0,
    }
}

func (this *SnapshotArray) Set(index int, val int) {
    this.data[index] = val
}

func (this *SnapshotArray) Snap() int {
    this.snapshots = append(this.snapshots, make(map[int]int))
    for k, v := range this.data {
        this.snapshots[len(this.snapshots)-1][k] = v
    }
    this.current++
    return this.current - 1
}

func (this *SnapshotArray) Get(index int) int {
    return this.snapshots[this.current][index]
}