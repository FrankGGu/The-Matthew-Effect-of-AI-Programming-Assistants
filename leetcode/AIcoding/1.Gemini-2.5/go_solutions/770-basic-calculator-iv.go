package main

import (
	"sort"
	"strconv"
	"strings"
	"unicode"
)

type Poly map[string]int

func toCanonicalString(term map[string]int) string {
	var vars []string
	for varName, power := range term {
		for i := 0; i < power; i++ {
			vars = append(vars, varName)
		}
	}
	sort.Strings(vars) // Sort variables alphabetically
	return strings.Join(vars, "*")
}

func parseCanonicalString(s string) map[string]int {
	term := make(map[string]int)
	if s == "" { // Constant term
		return term
	}
	parts := strings.Split(s, "*")
	for _, p := range parts {
		term[p]++
	}
	return term
}

func add(p1, p2 Poly) Poly {
	res := make(Poly)
	for k, v := range p1 {
		res[k] += v
	}
	for k, v := range p2 {
		res[k] += v
	}
	return res
}

func sub(p1, p2 Poly) Poly {
	res := make(Poly)
	for k, v := range p1 {
		res[k] += v
	}
	for k, v := range p2 {
		res[k] -= v
	}
	return res
}

func mul(p1, p2 Poly) Poly {
	res := make(Poly)
	for k1, v1 := range p1 {
		term1 := parseCanonicalString(k1)
		for k2, v2 := range p2 {
			term2 := parseCanonicalString(k2)

			// Combine terms
			combinedTerm := make(map[string]int)
			for varName, power := range term1 {
				combinedTerm[varName] += power
			}
			for varName, power := range term2 {
				combinedTerm[varName] += power
			}

			newCanonicalString := toCanonicalString(combinedTerm)
			res[newCanonicalString] += v1 * v2
		}
	}
	return res
}

var (
	expression string
	idx        int
	varsMap    map[string]int // values for variables
)

func basicCalculatorIV(expr string, evalMap []string) []string {
	expression = expr
	idx = 0
	varsMap = make(map[string]int)
	for _, assignment := range evalMap {
		parts := strings.Split(assignment, "=")
		val, _ := strconv.Atoi(parts[1])
		varsMap[parts[0]] = val
	}

	poly := parseExpression()

	// Prepare terms for sorting and final output
	type termInfo struct {
		canonical string
		coeff     int
		termMap   map[string]int // for calculating degree
	}
	var terms []termInfo
	for k, v := range poly {
		if v != 0 { // Only include terms with non-zero coefficients
			terms = append(terms, termInfo{k, v, parseCanonicalString(k)})
		}
	}

	// Sort terms
	sort.Slice(terms, func(i, j int) bool {
		// Calculate degree for term i
		degreeI := 0
		for _, power := range terms[i].termMap {
			degreeI += power
		}
		// Calculate degree for term j
		degreeJ := 0
		for _, power := range terms[j].termMap {
			degreeJ += power
		}

		// Primary sort: by degree (descending)
		if degreeI != degreeJ {
			return degreeI > degreeJ
		}
		// Secondary sort: by alphabetical order of canonical string
		return terms[i].canonical < terms[j].canonical
	})

	// Format output
	var result []string
	for _, t := range terms {
		if t.canonical == "" { // Constant term
			result = append(result, strconv.Itoa(t.coeff))
		} else {
			result = append(result, strconv.Itoa(t.coeff)+"*"+t.canonical)
		}
	}
	return result
}

func parseExpression() Poly {
	left := parseTerm()
	for idx < len(expression) {
		skipWhitespace()
		if idx >= len(expression) { // Re-check after skipping whitespace
			break
		}
		op := expression[idx]
		if op != '+' && op != '-' {
			break // Not an addition/subtraction operator
		}
		idx++ // Consume operator
		skipWhitespace()
		right := parseTerm()
		if op == '+' {
			left = add(left, right)
		} else { // op == '-'
			left = sub(left, right)
		}
	}
	return left
}

func parseTerm() Poly {
	left := parseFactor()
	for idx < len(expression) {
		skipWhitespace()
		if idx >= len(expression) { // Re-check after skipping whitespace
			break
		}
		op := expression[idx]
		if op != '*' {
			break // Not a multiplication operator
		}
		idx++ // Consume operator
		skipWhitespace()
		right := parseFactor()
		left = mul(left, right)
	}
	return left
}

func parseFactor() Poly {
	skipWhitespace()
	if idx >= len(expression) { // Handle end of string
		return Poly{}
	}
	if expression[idx] == '(' {
		idx++ // Consume '('
		poly := parseExpression()
		idx++ // Consume ')'
		return poly
	} else if unicode.IsDigit(rune(expression[idx])) {
		// Parse non-negative number
		start := idx
		for idx < len(expression) && unicode.IsDigit(rune(expression[idx])) {
			idx++
		}
		num, _ := strconv.Atoi(expression[start:idx])
		return Poly{"": num} // Constant term
	} else {
		// Parse variable
		start := idx
		for idx < len(expression) && unicode.IsLetter(rune(expression[idx])) {
			idx++
		}
		varName := expression[start:idx]
		if val, ok := varsMap[varName]; ok {
			return Poly{"": val} // Variable replaced by value
		} else {
			// Symbolic variable
			return Poly{varName: 1} // A single term with coefficient 1
		}
	}
}

func skipWhitespace() {
	for idx < len(expression) && expression[idx] == ' ' {
		idx++
	}
}