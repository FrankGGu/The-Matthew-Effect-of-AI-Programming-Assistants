import (
	"strconv"
)

type parser struct {
	expression string
	idx        int
	scopes     []map[string]int // Stack of scopes, each map represents a scope layer
}

func (p *parser) skipWhitespace() {
	for p.idx < len(p.expression) && p.expression[p.idx] == ' ' {
		p.idx++
	}
}

func (p *parser) readNextToken() string {
	p.skipWhitespace()
	if p.idx >= len(p.expression) {
		return "" // End of expression
	}

	char := p.expression[p.idx]
	if char == '(' || char == ')' {
		p.idx++
		return string(char)
	}

	// Read identifier or integer
	start := p.idx
	for p.idx < len(p.expression) && p.expression[p.idx] != ' ' && p.expression[p.idx] != '(' && p.expression[p.idx] != ')' {
		p.idx++
	}
	return p.expression[start:p.idx]
}

func (p *parser) peekNextToken() string {
	originalIdx := p.idx

	p.skipWhitespace()
	if p.idx >= len(p.expression) {
		p.idx = originalIdx // Restore index
		return ""
	}

	char := p.expression[p.idx]
	if char == '(' || char == ')' {
		p.idx = originalIdx // Restore index
		return string(char)
	}

	start := p.idx
	for p.idx < len(p.expression) && p.expression[p.idx] != ' ' && p.expression[p.idx] != '(' && p.expression[p.idx] != ')' {
		p.idx++
	}
	token := p.expression[start:p.idx]
	p.idx = originalIdx // Restore index
	return token
}

func (p *parser) evaluate() int {
	token := p.readNextToken() // Read the first token of the current expression

	if token == "(" { // It's a parenthesized expression (e.g., (add 1 2), (let x 1 x))
		command := p.readNextToken() // Read the command (add, mult, let)
		var result int

		switch command {
		case "let":
			p.scopes = append(p.scopes, make(map[string]int)) // Push a new scope layer for this let block

			for {
				p.skipWhitespace()
				// If the next token is ')', it means the current expression (at p.idx) is the body
				if p.peekNextToken() == ")" {
					result = p.evaluate() // Evaluate the body expression
					p.readNextToken()     // Consume the closing ')'
					break
				}

				// Otherwise, it's a variable-expression pair
				varName := p.readNextToken() // Read the variable name (e.g., "x")
				varValue := p.evaluate()    // Evaluate the expression for the variable's value
				p.scopes[len(p.scopes)-1][varName] = varValue // Bind variable in the current (topmost) scope
			}
			p.scopes = p.scopes[:len(p.scopes)-1] // Pop the scope layer after let finishes
			return result

		case "add":
			val1 := p.evaluate() // Evaluate the first argument
			val2 := p.evaluate() // Evaluate the second argument
			p.readNextToken()    // Consume the closing ')'
			return val1 + val2

		case "mult":
			val1 := p.evaluate() // Evaluate the first argument
			val2 := p.evaluate() // Evaluate the second argument
			p.readNextToken()    // Consume the closing ')'
			return val1 * val2
		}
	} else { // It's an integer literal or a variable
		// Try to parse as an integer
		if val, err := strconv.Atoi(token); err == nil {
			return val
		}
		// If not an integer, it must be a variable. Look up its value in the scope stack.
		for i := len(p.scopes) - 1; i >= 0; i-- { // Search from the innermost scope outwards
			if val, ok := p.scopes[i][token]; ok {
				return val
			}
		}
		// According to problem constraints, all variables will be defined.
		// This line should ideally not be reached.
		return 0 
	}
	return 0 // Should not be reached for valid expressions
}

func evaluate(expression string) int {
	p := &parser{
		expression: expression,
		idx:        0,
		scopes:     []map[string]int{}, // Initialize with an empty scope stack
	}
	return p.evaluate()
}