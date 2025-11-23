import (
	"strconv"
	"strings"
)

func solve() int {
	var s string
	var encryptedInts []int
	var sum int

	for _, str := range strings.Split(s, ",") {
		num, err := strconv.Atoi(str)
		if err == nil {
			encryptedInts = append(encryptedInts, num)
		}
	}

	for _, num := range encryptedInts {
		sum += num
	}

	return sum
}