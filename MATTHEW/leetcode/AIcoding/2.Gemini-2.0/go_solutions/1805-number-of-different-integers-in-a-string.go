import (
	"strings"
)

func numDifferentIntegers(word string) int {
	s := strings.Builder{}
	seen := make(map[string]bool)
	for i := 0; i < len(word); i++ {
		if word[i] >= '0' && word[i] <= '9' {
			s.WriteByte(word[i])
		} else {
			if s.Len() > 0 {
				num := s.String()
				s.Reset()
				j := 0
				for j < len(num)-1 && num[j] == '0' {
					j++
				}
				num = num[j:]
				seen[num] = true
			}
		}
	}
	if s.Len() > 0 {
		num := s.String()
		j := 0
		for j < len(num)-1 && num[j] == '0' {
			j++
		}
		num = num[j:]
		seen[num] = true
	}
	return len(seen)
}