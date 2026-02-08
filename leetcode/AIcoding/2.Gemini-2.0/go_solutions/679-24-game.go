import (
	"fmt"
	"math"
)

func judgePoint24(cards []int) bool {
	nums := make([]float64, len(cards))
	for i, v := range cards {
		nums[i] = float64(v)
	}
	return solve(nums)
}

func solve(nums []float64) bool {
	if len(nums) == 0 {
		return false
	}
	if len(nums) == 1 {
		return math.Abs(nums[0]-24) < 1e-6
	}

	for i := 0; i < len(nums); i++ {
		for j := 0; j < len(nums); j++ {
			if i == j {
				continue
			}

			nextNums := make([]float64, 0)
			for k := 0; k < len(nums); k++ {
				if k != i && k != j {
					nextNums = append(nextNums, nums[k])
				}
			}

			op := []func(float64, float64) float64{
				func(a, b float64) float64 { return a + b },
				func(a, b float64) float64 { return a - b },
				func(a, b float64) float64 { return a * b },
				func(a, b float64) float64 {
					if math.Abs(b) < 1e-6 {
						return math.MaxFloat64
					}
					return a / b
				},
			}

			for _, o := range op {
				res := o(nums[i], nums[j])
				if res == math.MaxFloat64 {
					continue
				}
				nextNums = append(nextNums, res)
				if solve(nextNums) {
					return true
				}
				nextNums = nextNums[:len(nextNums)-1]
			}
		}
	}

	return false
}