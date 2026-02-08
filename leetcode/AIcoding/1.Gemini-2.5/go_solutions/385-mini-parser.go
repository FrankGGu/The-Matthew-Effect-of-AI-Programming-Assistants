import (
	"strconv"
)

type NestedInteger struct {
	// Value is set if this NestedInteger holds a single integer.
	Value int
	// IsInt returns true if this NestedInteger holds a single integer, rather than a nested list.
	IsInt func() bool
	// GetInteger returns the single integer that this NestedInteger holds, if it holds a single integer.
	// The result is undefined if this NestedInteger holds a nested list.
	GetInteger func() int
	// SetInteger sets this NestedInteger to hold a single integer.
	SetInteger func(value int)
	// Add adds another NestedInteger to this NestedInteger, if it holds a nested list.
	// The result is undefined if this NestedInteger holds a single integer.
	Add func(elem NestedInteger)
	// GetList returns the nested list that this NestedInteger holds, if it holds a nested list.
	// The result is undefined if this NestedInteger holds a single integer.
	GetList func() []NestedInteger
}

func deserialize(s string) NestedInteger {
	if s == "" {
		return NestedInteger{}
	}

	// If the string does not start with '[', it must be a single integer.
	if s[0] != '[' {
		val, _ := strconv.Atoi(s)
		ni := NestedInteger{}
		ni.SetInteger(val)
		return ni
	}

	// For list parsing, use a stack to keep track of parent NestedIntegers.
	var stack []*NestedInteger
	var current *NestedInteger // The NestedInteger (list) currently being built
	numStart := -1             // Index where the current number string starts

	for i := 0; i < len(s); i++ {
		char := s[i]

		if char == '[' {
			// If there's an existing list being built, push it onto the stack
			// before starting a new nested list.
			if current != nil {
				stack = append(stack, current)
			}
			// Create a new empty NestedInteger, which will be a list by default.
			current = &NestedInteger{}
			numStart = -1 // Reset numStart for the new scope
		} else if char == ']' || char == ',' {
			// If we were parsing a number, complete it and add to the current list.
			if numStart != -1 {
				numStr := s[numStart:i]
				val, _ := strconv.Atoi(numStr)
				numNi := NestedInteger{}
				numNi.SetInteger(val)
				current.Add(numNi)
				numStart = -1 // Reset numStart
			}

			// If it's a closing bracket, the current list is complete.
			if char == ']' {
				// If there's a parent list on the stack, pop it and add the current
				// completed list to it. Then continue building the parent.
				if len(stack) > 0 {
					parent := stack[len(stack)-1]
					stack = stack[:len(stack)-1] // Pop parent from stack
					parent.Add(*current)         // Add the completed current list to parent
					current = parent             // Continue building the parent list
				}
				// If stack is empty, 'current' is the top-level list and thus the final result.
			}
		} else if char == '-' || (char >= '0' && char <= '9') {
			// If we encounter a digit or a minus sign, it marks the start of a number
			// if numStart hasn't been set yet for the current number.
			if numStart == -1 {
				numStart = i
			}
		}
	}

	return *current
}