type SnapshotArray struct {
    arr      []map[int]int
    snapID   int
}

func Constructor(length int) SnapshotArray {
    return SnapshotArray{
        arr:    make([]map[int]int, length),
        snapID: 0,
    }
}

func (this *SnapshotArray) Set(index int, val int) {
    if this.arr[index] == nil {
        this.arr[index] = make(map[int]int)
    }
    this.arr[index][this.snapID] = val
}

func (this *SnapshotArray) Snap() int {
    this.snapID++
    return this.snapID - 1
}

func (this *SnapshotArray) Get(index int, snap_id int) int {
    for i := snap_id; i >= 0; i-- {
        if val, ok := this.arr[index][i]; ok {
            return val
        }
    }
    return 0
}