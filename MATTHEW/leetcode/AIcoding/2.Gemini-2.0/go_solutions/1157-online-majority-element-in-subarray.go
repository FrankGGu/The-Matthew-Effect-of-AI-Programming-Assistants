import "math/rand"

type MajorityChecker struct {
	arr []int
	cnt map[int][]int
}

func Constructor(arr []int) MajorityChecker {
	cnt := make(map[int][]int)
	for i, v := range arr {
		cnt[v] = append(cnt[v], i)
	}
	return MajorityChecker{arr: arr, cnt: cnt}
}

func (this *MajorityChecker) Query(left int, right int, threshold int) int {
	for i := 0; i < 20; i++ {
		idx := left + rand.Intn(right-left+1)
		val := this.arr[idx]
		pos := this.cnt[val]
		l := 0
		r := len(pos) - 1
		for l <= r {
			mid := (l + r) / 2
			if pos[mid] < left {
				l = mid + 1
			} else {
				r = mid - 1
			}
		}
		leftIdx := l
		l = 0
		r = len(pos) - 1
		for l <= r {
			mid := (l + r) / 2
			if pos[mid] > right {
				r = mid - 1
			} else {
				l = mid + 1
			}
		}
		rightIdx := r
		if rightIdx-leftIdx+1 >= threshold {
			return val
		}
	}
	return -1
}