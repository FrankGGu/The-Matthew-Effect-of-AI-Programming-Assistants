import (
	"fmt"
	"strconv"
)

func simplifiedFractions(n int) []string {
	result := []string{}
	for i := 2; i <= n; i++ {
		for j := 1; j < i; j++ {
			if gcd(i, j) == 1 {
				result = append(result, strconv.Itoa(j)+"/"+strconv.Itoa(i))
			}
		}
	}
	return result
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}