import (
	"math"
	"math/bits"
	"strconv"
)

func smallestGoodBase(n string) string {
	num, _ := strconv.ParseUint(n, 10, 64)
	maxM := bits.Len64(num) - 1
	for m := maxM; m > 1; m-- {
		k := uint64(math.Pow(float64(num), 1.0/float64(m)))
		if k < 2 {
			continue
		}
		sum := uint64(1)
		curr := uint64(1)
		for i := 1; i <= m; i++ {
			curr *= k
			sum += curr
		}
		if sum == num {
			return strconv.FormatUint(k, 10)
		}
	}
	return strconv.FormatUint(num-1, 10)
}