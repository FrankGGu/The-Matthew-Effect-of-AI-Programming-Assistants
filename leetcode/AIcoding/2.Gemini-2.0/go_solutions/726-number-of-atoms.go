import (
	"sort"
	"strconv"
	"strings"
)

func countOfAtoms(formula string) string {
	i := 0
	var helper func() map[string]int
	helper = func() map[string]int {
		counts := make(map[string]int)
		for i < len(formula) {
			c := formula[i]
			if c == '(' {
				i++
				subCounts := helper()
				num := 1
				if i < len(formula) && '0' <= formula[i] && formula[i] <= '9' {
					start := i
					for i < len(formula) && '0' <= formula[i] && formula[i] <= '9' {
						i++
					}
					num, _ = strconv.Atoi(formula[start:i])
				}
				for atom, count := range subCounts {
					counts[atom] += count * num
				}
			} else if c == ')' {
				i++
				return counts
			} else if 'A' <= c && c <= 'Z' {
				start := i
				i++
				for i < len(formula) && 'a' <= formula[i] && formula[i] <= 'z' {
					i++
				}
				atom := formula[start:i]
				num := 1
				if i < len(formula) && '0' <= formula[i] && formula[i] <= '9' {
					start := i
					for i < len(formula) && '0' <= formula[i] && formula[i] <= '9' {
						i++
					}
					num, _ = strconv.Atoi(formula[start:i])
				}
				counts[atom] += num
			} else {
				i++
			}
		}
		return counts
	}

	counts := helper()
	atoms := make([]string, 0, len(counts))
	for atom := range counts {
		atoms = append(atoms, atom)
	}
	sort.Strings(atoms)

	var result strings.Builder
	for _, atom := range atoms {
		result.WriteString(atom)
		if counts[atom] > 1 {
			result.WriteString(strconv.Itoa(counts[atom]))
		}
	}

	return result.String()
}