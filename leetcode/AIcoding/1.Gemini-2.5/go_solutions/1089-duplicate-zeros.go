func duplicateZeros(arr []int) {
	n := len(arr)
	if n == 0 {
		return
	}

	// First pass: Determine the effective end of the original array
	// that will contribute to the modified array.
	// 'i' will be the pointer for the original array (read pointer).
	// 'j' will be the conceptual pointer for the modified array length.

	i := 0 // Pointer for iterating through the original array
	j := 0 // Conceptual pointer for the modified array length

	// Find the point where the modified array would be full or overflow
	for i < n {
		if arr[i] == 0 {
			j += 2 // A zero takes two spots
		} else {
			j += 1 // A non-zero takes one spot
		}

		if j >= n { // If we've reached or exceeded the original array's length
			break
		}
		i++
	}

	// Now, 'i' is the last index in the original array that we considered.
	// 'j' is the conceptual length if we were to place elements up to arr[i].

	// Initialize write and read pointers for the second pass (reverse copy)
	writePtr := n - 1
	readPtr := i

	// Handle the special case where the last element considered (arr[i]) was a zero
	// and only one copy of it fits into the array.
	// This happens if j (conceptual length) became n+1 because of arr[i] being a zero.
	if j == n+1 {
		arr[writePtr] = 0 // Place the single zero
		writePtr--
		readPtr-- // Move readPtr to the element before arr[i]
	}

	// Second pass: Copy elements from right to left
	// readPtr now points to the last element in the original array that needs to be copied.
	// writePtr points to the last available slot in the target array.
	for writePtr >= 0 && readPtr >= 0 {
		if arr[readPtr] == 0 {
			arr[writePtr] = 0
			writePtr--
			// The problem statement guarantees that we do not write beyond the original length.
			// The `j == n+1` check ensures that if the second zero doesn't fit, it's already handled.
			// So, if we reach here, the second zero will always fit.
			arr[writePtr] = 0
			writePtr--
		} else {
			arr[writePtr] = arr[readPtr]
			writePtr--
		}
		readPtr--
	}
}