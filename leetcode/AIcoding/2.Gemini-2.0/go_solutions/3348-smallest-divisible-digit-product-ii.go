import (
	"fmt"
	"sort"
	"strconv"
)

func smallestDivisibleDigitProduct(n, target int) string {
	if target == 1 {
		res := ""
		for i := 0; i < n; i++ {
			res += "1"
		}
		return res
	}

	var digits []int
	for i := 9; i >= 2; i-- {
		for target%i == 0 {
			digits = append(digits, i)
			target /= i
		}
	}

	if target != 1 {
		return "-1"
	}

	sort.Ints(digits)

	if len(digits) > n {
		return "-1"
	}

	res := ""
	for _, digit := range digits {
		res += strconv.Itoa(digit)
	}

	if len(res) > n {
		return "-1"
	}

	for len(res) < n {
		res = "1" + res
	}

	return res
}