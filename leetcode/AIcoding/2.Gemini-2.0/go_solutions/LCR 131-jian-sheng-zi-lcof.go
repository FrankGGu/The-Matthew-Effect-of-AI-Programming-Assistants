import (
	"fmt"
	"math"
)

func minOperations(bamboo []int) int {
	n := len(bamboo)
	ans := 0
	for i := 0; i < n; i++ {
		for bamboo[i] > 0 {
			maxIndex := i
			for j := i + 1; j < n; j++ {
				if bamboo[j] > bamboo[maxIndex] {
					maxIndex = j
				}
			}

			if bamboo[maxIndex] <= 0 {
				break
			}

			target := int(math.Ceil(math.Sqrt(float64(bamboo[maxIndex]))))
			if target == bamboo[maxIndex] {
				target--
			}

			diff := bamboo[maxIndex] - target

			for j := 0; j < n; j++ {
				if bamboo[j] > 0 {
					bamboo[j] = int(math.Max(0, float64(bamboo[j]-diff)))
				}
			}
			ans++
		}
	}
	return ans
}