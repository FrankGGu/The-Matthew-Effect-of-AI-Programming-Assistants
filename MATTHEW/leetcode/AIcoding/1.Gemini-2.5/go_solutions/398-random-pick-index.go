type Solution struct {
	indices map[int][]int
}

func Constructor(nums []int) Solution {
	rand.Seed(time.Now().UnixNano())

	m := make(map[int][]int)
	for i, num :=