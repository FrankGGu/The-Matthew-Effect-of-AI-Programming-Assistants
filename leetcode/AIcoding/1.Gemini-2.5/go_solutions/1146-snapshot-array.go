import "sort"

type SnapshotArray struct {
	data          [][]struct {
		snapId int
		val    int
	}
	currentSnapId int
}

func Constructor(length int) SnapshotArray {
	data := make([][]struct {
		snapId int
		val    int
	}, length)
	for i := 0; i < length; i++ {
		data[i] = []struct {
			snapId int
			val    int
		}{
			{snapId: 0, val: 0}, // Initialize with default value 0 at snapId 0
		}
	}
	return SnapshotArray{
		data:          data,
		currentSnapId: 0,
	}
}

func (this *SnapshotArray) Set(index int, val int) {
	// If the last entry for this index is from the current snapId, update it.
	// Otherwise, append a new entry.
	// This optimization prevents redundant entries if Set is called multiple times for the same index
	// before a snapshot is taken. However, the problem statement implies that each Set call records a change.
	// The simpler approach of always appending is also correct and usually what's expected for this problem.
	// Let's stick to always appending as it's simpler and matches the 'history' concept better.
	// The initial {0,0} entry handles the case where Get is called before any Set.
	// If we don't include {0,0} initially, Get would need to handle an empty slice.
	// With {0,0}, Get's binary search logic simplifies.

	// Check if the last entry was made at the currentSnapId.
	// If so, update it. This is an optimization to avoid storing multiple values
	// for the same index within the same snapshot ID.
	lastIdx := len(this.data[index]) - 1
	if this.data[index][lastIdx].snapId == this.currentSnapId {
		this.data[index][lastIdx].val = val
	} else {
		this.data[index] = append(this.data[index], struct {
			snapId int
			val    int
		}{snapId: this.currentSnapId, val: val})
	}
}

func (this *SnapshotArray) Snapshot() int {
	oldSnapId := this.currentSnapId
	this.currentSnapId++
	return oldSnapId
}

func (this *SnapshotArray) Get(index int, snap_id int) int {
	// Find the largest snapId in data[index] that is less than or equal to the given snap_id.
	// sort.Search returns the smallest index i such that f(i) is true.
	// We want to find the first entry whose snapId is GREATER than the target snap_id.
	// The element just before that (at i-1) will be the one we need.

	idx := sort.Search(len(this.data[index]), func(i int) bool {
		return this.data[index][i].snapId > snap_id
	})

	// If idx is 0, it means all snapIds in data[index] are greater than snap_id.
	// This should not happen if we initialize with {0,0} and snap_id >= 0.
	// However, if snap_id is less than the first recorded snapId, it means the value was 0.
	// The initial {0,0} entry ensures that idx will be at least 1 if snap_id >= 0.
	// So, we always look at idx-1.
	return this.data[index][idx-1].val
}