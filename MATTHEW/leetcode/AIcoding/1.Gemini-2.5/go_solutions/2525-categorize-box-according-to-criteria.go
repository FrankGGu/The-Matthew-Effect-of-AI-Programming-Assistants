func categorizeBox(length int, width int, height int, mass int) string {
	const (
		LWHThreshold int64 = 10000
		VolumeThreshold int64 = 1000000000 // 10^9
		MassThreshold int64 = 100
	)

	isBulky := false
	isHeavy := false

	// Check for bulky conditions
	// Convert dimensions to int64 before multiplication to prevent overflow for volume calculation
	l64 := int64(length)
	w64 := int64(width)
	h64 := int64(height)

	volume := l64 * w64 * h64

	if l64 >= LWHThreshold || w64 >= LWHThreshold || h64 >= LWHThreshold || volume >= VolumeThreshold {
		isBulky = true
	}

	// Check for heavy conditions
	if int64(mass) >= MassThreshold {
		isHeavy = true
	}

	// Categorize the box
	if isBulky && isHeavy {
		return "Both"
	} else if isBulky {
		return "Bulky"
	} else if isHeavy {
		return "Heavy"
	} else {
		return "Neither"
	}
}