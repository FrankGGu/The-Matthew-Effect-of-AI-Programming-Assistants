import (
	"fmt"
	"strconv"
	"strings"
)

func abbreviateProduct(left int, right int) string {
	p := 1.0
	trailingZeros := 0
	mod := 1
	for i := left; i <= right; i++ {
		num := i
		for num%2 == 0 {
			num /= 2
			trailingZeros++
		}
		for num%5 == 0 {
			num /= 5
			trailingZeros++
		}
		p *= float64(num)
		mod *= num
		mod %= 100000
		for p > 1e12 {
			p /= 10
		}
	}

	s := strconv.Itoa(mod)
	for len(s) < 5 {
		s = "0" + s
	}

	if p >= 1e10 {
		return fmt.Sprintf("%de+%d", int(p/1e9), trailingZeros)
	}

	product := 1
	for i := left; i <= right; i++ {
		product *= i
	}

	sProduct := strconv.Itoa(product)

	if len(sProduct) <= 10 {
		return fmt.Sprintf("%s", sProduct[:]) + "e+" + strconv.Itoa(trailingZeros)
	}

	sP := fmt.Sprintf("%.5g", p)

	parts := strings.Split(sP, "e")

	if len(parts) > 1 {
		return parts[0] + "e+" + strconv.Itoa(trailingZeros)
	}

	first := fmt.Sprintf("%.5g", p)
	firstPart := strings.Split(first, ".")

	if len(firstPart) == 1 {
		firstPart = strings.Split(first, ",")
	}

	if len(firstPart) == 1 {
		return fmt.Sprintf("%de+%d", int(p/1e9), trailingZeros)
	}

	f := firstPart[0] + "." + firstPart[1][:4]
	return f + "e+" + strconv.Itoa(trailingZeros)
}