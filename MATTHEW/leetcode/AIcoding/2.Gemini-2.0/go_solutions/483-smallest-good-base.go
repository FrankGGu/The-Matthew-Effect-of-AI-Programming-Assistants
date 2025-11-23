import (
	"math"
	"strconv"
)

func smallestGoodBase(n string) string {
	num, _ := strconv.ParseInt(n, 10, 64)
	m := int(math.Log(float64(num)) / math.Log(2.0))
	for m >= 1 {
		k := int(math.Pow(float64(num), 1.0/float64(m)))
		sum := 1
		power := 1
		for i := 1; i <= m; i++ {
			power *= k
			sum += power
		}
		if int64(sum) == num {
			return strconv.Itoa(k)
		}
		m--
	}
	return strconv.FormatInt(num-1, 10)
}