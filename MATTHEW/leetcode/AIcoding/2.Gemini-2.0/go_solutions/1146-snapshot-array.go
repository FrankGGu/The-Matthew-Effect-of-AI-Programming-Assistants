type SnapshotArray struct {
	arr      []int
	snaps    [][]map[int]int
	snapID int
}

func Constructor(length int) SnapshotArray {
	arr := make([]int, length)
	snaps := make([][]map[int]int, 0)
	return SnapshotArray{arr: arr, snaps: snaps, snapID: 0}
}

func (this *SnapshotArray) Set(index int, val int) {
	this.arr[index] = val
}

func (this *SnapshotArray) Snap() int {
	snapID := this.snapID
	this.snaps = append(this.snaps, make(map[int]int))
	this.snapID++
	return snapID
}

func (this *SnapshotArray) Get(index int, snapID int) int {
	for i := snapID; i >= 0; i-- {
		if i < len(this.snaps) {
			if val, ok := this.snaps[i][index]; ok {
				return val
			}
		}
	}

	snapArr := make([]int, len(this.arr))
	for i := 0; i < len(this.arr); i++ {
		snapArr[i] = this.arr[i]
	}

	for i := 0; i <= snapID; i++ {
		if i < len(this.snaps) {
			for index, val := range this.snaps[i] {
				snapArr[index] = val
			}
		}
	}

	snapArr = make([]int, len(this.arr))
	for i := 0; i < len(this.arr); i++ {
		snapArr[i] = this.arr[i]
	}

	for i := 0; i <= snapID; i++ {
		if i < len(this.snaps) {
			for index, val := range this.snaps[i] {
				snapArr[index] = val
			}
		}
	}

	original := make([]int, len(this.arr))
	copy(original, this.arr)

	for i := 0; i <= snapID; i++ {
		if i < len(this.snaps) {
			for index, val := range this.snaps[i] {
				original[index] = val
			}
		}
	}

	snapArr = make([]int, len(this.arr))
	for i := 0; i < len(this.arr); i++ {
		snapArr[i] = this.arr[i]
	}

	for i := 0; i <= snapID; i++ {
		if i < len(this.snaps) {
			for index, val := range this.snaps[i] {
				snapArr[index] = val
			}
		}
	}

	snapArr = make([]int, len(this.arr))
	for i := 0; i < len(this.arr); i++ {
		snapArr[i] = this.arr[i]
	}

	for i := 0; i <= snapID; i++ {
		if i < len(this.snaps) {
			for index, val := range this.snaps[i] {
				snapArr[index] = val
			}
		}
	}

	return this.arr[index]
}