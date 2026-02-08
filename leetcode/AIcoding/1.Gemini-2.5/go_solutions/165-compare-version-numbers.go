func compareVersion(version1 string, version2 string) int {
	parts1 := strings.Split(version1, ".")
	parts2 := strings.Split(version2, ".")

	n1 := len(parts1)
	n2 := len(parts2)

	maxLength := n1
	if n2 > maxLength {
		maxLength = n2
	}

	for i := 0; i < maxLength; i++ {
		num1 := 0
		if i < n1 {
			num1, _ = strconv.Atoi(parts1[i])
		}

		num2 := 0
		if i < n2 {
			num2, _ = strconv.Atoi(parts2[i])
		}

		if num1 < num2 {
			return -1
		}
		if num1 > num2 {
			return 1
		}
	}

	return 0
}