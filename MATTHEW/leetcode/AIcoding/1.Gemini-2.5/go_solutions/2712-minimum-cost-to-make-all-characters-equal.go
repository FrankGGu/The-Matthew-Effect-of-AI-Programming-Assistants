func minimumCost(s string) int64 {
	n := len(s)
	var totalCost int64 = 0
	currentFlipParity := 0 // 0 means s[i] is effectively in its original state, 1 means it's effectively flipped

	for i := 0; i < n-1; i++ {
		charIVal := int(s[i] - '0')
		charIPlus1Val := int(s[i+1] - '0')

		// Calculate effective values for s[i] and s[i+1]
		// effective_char_i_val is s[i]'s original value XORed with currentFlipParity
		// effective_char_i_plus_1_val is s[i+1]'s original value XORed with currentFlipParity
		effectiveCharIVal := charIVal ^ currentFlipParity
		effectiveCharIPlus1Val := charIPlus1Val ^ currentFlipParity

		// If effective_char_i_val and effective_char_i_plus_1_val are different,
		// we have a discrepancy that needs to be resolved.
		if effectiveCharIVal != effectiveCharIPlus1Val {
			// Option 1: Apply prefix flip s[0...i]. Cost is i + 1.
			// This flips s[0...i]. So, effective_char_i_val flips, making it equal to effective_char_i_plus_1_val.
			// For subsequent characters s[j] (where j > i), their effective state will be toggled.
			// This means currentFlipParity for the next iteration (i+1) will be 1 - currentFlipParity.

			// Option 2: Apply suffix flip s[i+1...n-1]. Cost is n - (i + 1).
			// This flips s[i+1...n-1]. So, effective_char_i_plus_1_val flips, making it equal to effective_char_i_val.
			// For subsequent characters s[j] (where j > i), their effective state is NOT toggled
			// by this operation (because this operation only affects s[i+1] onwards, not s[i] or characters before it relative to s[i]).
			// This means currentFlipParity for the next iteration (i+1) remains unchanged.

			costPrefix := int64(i + 1)
			costSuffix := int64(n - (i + 1))

			if costPrefix < costSuffix {
				totalCost += costPrefix
				currentFlipParity = 1 - currentFlipParity // Toggle flip state for subsequent characters
			} else {
				totalCost += costSuffix
				// currentFlipParity remains unchanged
			}
		}
	}

	return totalCost
}