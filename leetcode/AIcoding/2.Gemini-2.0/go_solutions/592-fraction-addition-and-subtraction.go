import (
	"fmt"
	"strconv"
	"strings"
)

func fractionAddition(expression string) string {
	nums := []int{}
	op := 1
	i := 0
	for i < len(expression) {
		sign := 1
		if expression[i] == '+' {
			i++
		} else if expression[i] == '-' {
			sign = -1
			i++
		}

		num := 0
		for i < len(expression) && expression[i] >= '0' && expression[i] <= '9' {
			num = num*10 + int(expression[i]-'0')
			i++
		}
		nums = append(nums, sign*num*op)
		i++

		num = 0
		for i < len(expression) && expression[i] >= '0' && expression[i] <= '9' {
			num = num*10 + int(expression[i]-'0')
			i++
		}
		nums = append(nums, num)
		op = num
	}

	num := nums[0]
	den := nums[1]
	for i := 2; i < len(nums); i += 2 {
		num = num*nums[i+1] + nums[i]*den
		den = den * nums[i+1]
		gcdVal := gcd(abs(num), den)
		num /= gcdVal
		den /= gcdVal
	}

	return strconv.Itoa(num) + "/" + strconv.Itoa(den)
}

func gcd(a, b int) int {
	if b == 0 {
		return a
	}
	return gcd(b, a%b)
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}