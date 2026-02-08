type Solution struct {
	rects [][]int
	areas []int // cumulative sum of areas
	rand  *rand.Rand
}

func Constructor(rects [][]int) Solution {
	s := Solution{
		rect