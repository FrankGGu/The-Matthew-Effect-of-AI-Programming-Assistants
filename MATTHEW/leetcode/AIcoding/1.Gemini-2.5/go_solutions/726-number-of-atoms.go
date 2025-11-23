import (
	"sort"
	"strconv"
	"strings"
)

func countOfAtoms(formula string) string {
	n := len(formula)
	i := 0 // current index

	stack := []map[string]int{{}} // Stack to hold maps of atom counts at different nesting levels

	for i < n {
		if formula[i] == '(' {
			stack = append(stack, map[string]int{}) // Push new map for new scope
			i++
		} else if formula[i] == ')' {
			currentMap := stack[len(stack)-1] // Get map for current scope
			stack = stack[:len(stack)-1]       // Pop current map

			i++ // Move past ')'

			// Read multiplier after ')'
			multiplier := 1
			start := i
			for i < n && formula[i] >= '0' && formula[i] <= '9' {
				i++
			}
			if i > start {
				val, _ := strconv.Atoi(formula[start:i])
				multiplier = val
			}

			// Merge currentMap into the map below it, applying the multiplier
			topMap := stack[len(stack)-1]
			for atom, count := range currentMap {
				topMap[atom] += count * multiplier
			}

		} else { // Element symbol
			start := i
			i++ // First char is always uppercase

			// Read lowercase letters for the element name
			for i < n && formula[i] >= 'a' && formula[i] <= 'z' {
				i++
			}
			atom := formula[start:i]

			// Read count for the atom
			count := 1
			start = i
			for i < n && formula[i] >= '0' && formula[i] <= '9' {
				i++
			}
			if i > start {
				val, _ := strconv.Atoi(formula[start:i])
				count = val
			}

			// Add to the current scope's map
			topMap := stack[len(stack)-1]
			topMap[atom] += count
		}
	}

	// After parsing, the final counts are in the first (and only remaining) map on the stack
	finalCounts := stack[0]

	// Collect atom names and sort them
	atoms := make([]string, 0, len(finalCounts))
	for atom := range finalCounts {
		atoms = append(atoms, atom)
	}
	sort.Strings(atoms)

	// Build the result string
	var result strings.Builder
	for _, atom := range atoms {
		result.WriteString(atom)
		count := finalCounts[atom]
		if count > 1 {
			result.WriteString(strconv.Itoa(count))
		}
	}

	return result.String()
}