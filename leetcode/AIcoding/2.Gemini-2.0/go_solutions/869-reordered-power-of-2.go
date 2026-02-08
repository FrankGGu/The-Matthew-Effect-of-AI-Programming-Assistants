import (
	"strconv"
)

func reorderedPowerOf2(n int) bool {
	s := strconv.Itoa(n)
	perms := permutations(s)
	for _, perm := range perms {
		if perm[0] == '0' {
			continue
		}
		num, _ := strconv.Atoi(perm)
		if num > 0 && (num&(num-1)) == 0 {
			return true
		}
	}
	return false
}

func permutations(s string) []string {
	var result []string
	var backtrack func(string, string)

	backtrack = func(curr string, remaining string) {
		if len(remaining) == 0 {
			result = append(result, curr)
			return
		}

		for i := 0; i < len(remaining); i++ {
			newCurr := curr + string(remaining[i])
			newRemaining := remaining[:i] + remaining[i+1:]
			backtrack(newCurr, newRemaining)
		}
	}

	backtrack("", s)
	return result
}