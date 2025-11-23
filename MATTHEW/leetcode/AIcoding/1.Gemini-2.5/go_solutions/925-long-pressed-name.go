func isLongPressedName(name string, typed string) bool {
	i := 0 // Pointer for name
	j := 0 // Pointer for typed

	for j < len(typed) {
		if i < len(name) && name[i] == typed[j] {
			// Character matches name, advance both pointers
			i