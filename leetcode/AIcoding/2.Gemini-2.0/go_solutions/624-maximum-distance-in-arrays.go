import "math"

func maxDistance(arrays [][]int) int {
	minVal := arrays[0][0]
	maxVal := arrays[0][len(arrays[0])-1]
	res := 0
	for i := 1; i < len(arrays); i++ {
		res = int(math.Max(float64(res), float64(abs(arrays[i][len(arrays[i])-1]-minVal))))
		res = int(math.Max(float64(res), float64(abs(maxVal-arrays[i][0]))))
		minVal = int(math.Min(float64(minVal), float64(arrays[i][0])))
		maxVal = int(math.Max(float64(maxVal), float64(arrays[i][len(arrays[i])-1])))
	}
	return res
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}