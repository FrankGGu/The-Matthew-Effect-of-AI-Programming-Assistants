func categorizeBox(length int, width int, height int, mass int) string {
	bulky := false
	heavy := false
	volume := length * width * height
	if length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000 {
		bulky = true
	}
	if mass >= 100 {
		heavy = true
	}

	if bulky && heavy {
		return "Both"
	} else if bulky {
		return "Bulky"
	} else if heavy {
		return "Heavy"
	} else {
		return "Neither"
	}
}