import (
	"sort"
)

func maxAreaRect(points [][]int) int {
	n := len(points)
	if n <= 1 {
		return 0
	}

	type Event struct {
		x, y1, y2, type_ int
	}

	events := make([]Event, 0, 2*n)
	for _, p := range points {
		events = append(events, Event{p[0], p[1], 1000000000, 1})
		events = append(events, Event{p[0], 0, p[1], -1})
	}

	sort.Slice(events, func(i, j int) bool {
		if events[i].x != events[j].x {
			return events[i].x < events[j].x
		}
		return events[i].type_ < events[j].type_
	})

	ys := make(map[int]bool)
	for _, p := range points {
		ys[p[1]] = true
	}
	yList := make([]int, 0, len(ys))
	for y := range ys {
		yList = append(yList, y)
	}
	sort.Ints(yList)

	yMap := make(map[int]int)
	for i, y := range yList {
		yMap[y] = i
	}

	tree := NewSegmentTree(len(yList))
	prevX := events[0].x
	ans := 0

	for _, e := range events {
		ans = max(ans, tree.Query()* (e.x - prevX))
		prevX = e.x

		if e.type_ == 1 {
			tree.Update(yMap[e.y1], len(yList)-1, 1)
		} else {
			tree.Update(0, yMap[e.y2], -1)
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

type SegmentTree struct {
	tree []int
	lazy []int
	size int
}

func NewSegmentTree(size int) *SegmentTree {
	return &SegmentTree{
		tree: make([]int, 4*size),
		lazy: make([]int, 4*size),
		size: size,
	}
}

func (st *SegmentTree) pushDown(node, start, end int) {
	if st.lazy[node] == 0 {
		return
	}

	st.tree[node] += st.lazy[node]
	if start != end {
		st.lazy[2*node+1] += st.lazy[node]
		st.lazy[2*node+2] += st.lazy[node]
	}
	st.lazy[node] = 0
}

func (st *SegmentTree) Update(l, r, val int) {
	st.updateHelper(0, 0, st.size-1, l, r, val)
}

func (st *SegmentTree) updateHelper(node, start, end, l, r, val int) {
	st.pushDown(node, start, end)
	if start > r || end < l {
		return
	}
	if l <= start && end <= r {
		st.lazy[node] += val
		st.pushDown(node, start, end)
		return
	}

	mid := (start + end) / 2
	st.updateHelper(2*node+1, start, mid, l, r, val)
	st.updateHelper(2*node+2, mid+1, end, l, r, val)
	st.tree[node] = max(st.tree[2*node+1], st.tree[2*node+2])
}

func (st *SegmentTree) Query() int {
	return st.tree[0]
}