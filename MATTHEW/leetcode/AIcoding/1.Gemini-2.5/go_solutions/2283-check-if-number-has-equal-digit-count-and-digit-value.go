func digitCount(num string) bool {
    // Create a frequency map (or array) to store counts of each digit 0-9
    counts := make([]int, 10)

    // Populate the counts array by iterating through the input string
    for _, char := range num {
        digit := int(char - '0')