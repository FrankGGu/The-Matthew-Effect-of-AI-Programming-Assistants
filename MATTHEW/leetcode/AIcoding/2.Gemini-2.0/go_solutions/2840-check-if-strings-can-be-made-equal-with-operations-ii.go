import (
	"sort"
	"strings"
)

func checkStrings(s1 string, s2 string) bool {
	s1Odd := strings.Builder{}
	s1Even := strings.Builder{}
	s2Odd := strings.Builder{}
	s2Even := strings.Builder{}

	for i := 0; i < len(s1); i++ {
		if i%2 == 0 {
			s1Even.WriteByte(s1[i])
			s2Even.WriteByte(s2[i])
		} else {
			s1Odd.WriteByte(s1[i])
			s2Odd.WriteByte(s2[i])
		}
	}

	s1EvenStr := []byte(s1Even.String())
	s1OddStr := []byte(s1Odd.String())
	s2EvenStr := []byte(s2Even.String())
	s2OddStr := []byte(s2Odd.String())

	sort.Slice(s1EvenStr, func(i, j int) bool {
		return s1EvenStr[i] < s1EvenStr[j]
	})

	sort.Slice(s1OddStr, func(i, j int) bool {
		return s1OddStr[i] < s1OddStr[j]
	})

	sort.Slice(s2EvenStr, func(i, j int) bool {
		return s2EvenStr[i] < s2EvenStr[j]
	})

	sort.Slice(s2OddStr, func(i, j int) bool {
		return s2OddStr[i] < s2OddStr[j]
	})

	return string(s1EvenStr) == string(s2EvenStr) && string(s1OddStr) == string(s2OddStr)
}