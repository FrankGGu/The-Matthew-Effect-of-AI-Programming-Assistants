package main

func maxNumberOfFamilies(n int, reservedSeats [][]int) int {
	reservedByRow := make(map[int]int) // row_id -> bitmask of reserved columns

	for _, seat := range reservedSeats {
		row := seat[0]
		col := seat[1]
		// Set the bit for the reserved column. Columns are 1-indexed, so (col - 1) for 0-indexed bit.
		reservedByRow[row] |= (1 << (col - 1))
	}

	// Start with families from rows that have no reservations.
	// Each such row can accommodate 2 families.
	totalFamilies := (n - len(reservedByRow)) * 2

	// Masks for the three possible 4-seat blocks
	// Block 2-5: bits 1,2,3,4 (corresponding to columns 2,3,4,5)
	leftBlockMask := (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4)
	// Block 4-7: bits 3,4,5,6 (corresponding to columns 4,5,6,7)
	middleBlockMask := (1 << 3) | (1 << 4) | (1 << 5) | (1 << 6)
	// Block 6-9: bits 5,6,7,8 (corresponding to columns 6,7,8,9)
	rightBlockMask := (1 << 5) | (1 << 6) | (1 << 7) | (1 << 8)

	for _, reservedColsMask := range reservedByRow {
		familiesInThisRow := 0

		isLeftBlockFree := (reservedColsMask & leftBlockMask) == 0
		isRightBlockFree := (reservedColsMask & rightBlockMask) == 0

		if isLeftBlockFree && isRightBlockFree {
			// If both left (2-5) and right (6-9) blocks are free, two families can be seated.
			familiesInThisRow = 2
		} else {
			// Otherwise, check if at least one block (2-5, 4-7, or 6-9) is free for one family.
			isMiddleBlockFree := (reservedColsMask & middleBlockMask) == 0
			if isLeftBlockFree || isMiddleBlockFree || isRightBlockFree {
				familiesInThisRow = 1
			}
		}
		totalFamilies += familiesInThisRow
	}

	return totalFamilies
}