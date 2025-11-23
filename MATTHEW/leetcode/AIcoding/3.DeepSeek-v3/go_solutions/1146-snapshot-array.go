type SnapshotArray struct {
    snapshots [][]map[int]int
    snapID    int
}

func Constructor(length int) SnapshotArray {
    snapshots := make([][]map[int]int, length)
    for i := range snapshots {
        snapshots[i] = make([]map[int]int, 0)
        snapshots[i] = append(snapshots[i], make(map[int]int))
    }
    return SnapshotArray{
        snapshots: snapshots,
        snapID:    0,
    }
}

func (this *SnapshotArray) Set(index int, val int) {
    this.snapshots[index][len(this.snapshots[index])-1][this.snapID] = val
}

func (this *SnapshotArray) Snap() int {
    this.snapID++
    return this.snapID - 1
}

func (this *SnapshotArray) Get(index int, snap_id int) int {
    snapList := this.snapshots[index]
    for i := len(snapList) - 1; i >= 0; i-- {
        for s, val := range snapList[i] {
            if s <= snap_id {
                return val
            }
        }
    }
    return 0
}