import (
	"strconv"
	"strings"
)

func ambiguousCoordinates(s string) []string {
	s = s[1 : len(s)-1]
	n := len(s)
	res := []string{}

	for i := 1; i < n; i++ {
		left := s[:i]
		right := s[i:]

		leftCoords := possibleCoords(left)
		rightCoords := possibleCoords(right)

		for _, l := range leftCoords {
			for _, r := range rightCoords {
				res = append(res, "("+l+", "+r+")")
			}
		}
	}

	return res
}

func possibleCoords(s string) []string {
	res := []string{}
	n := len(s)

	if n == 1 {
		res = append(res, s)
		return res
	}

	if s[0] == '0' && s[n-1] == '0' {
		return res
	}

	if s[0] == '0' {
		res = append(res, "0."+s[1:])
		return res
	}

	if s[n-1] == '0' {
		res = append(res, s)
		return res
	}

	res = append(res, s)

	for i := 1; i < n; i++ {
		res = append(res, s[:i]+"."+s[i:])
	}

	return res
}