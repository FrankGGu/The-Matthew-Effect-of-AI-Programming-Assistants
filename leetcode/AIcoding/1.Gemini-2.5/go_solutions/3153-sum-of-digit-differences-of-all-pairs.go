func sumDigitDifferences(nums []int) int64 {
    var totalSumDiff int64 = 0

    currentPowerOf10 := 1 // Represents 10^p for the current digit position

    // Iterate for each digit position.
    // Given nums[i] up to 10^9, there are at most 10 digits (0-9).
    // p=0 for units place (10^0), p=1 for tens place (10^1), ..., p=9 for billions place (10^9).
    for p := 0; p < 10; p++ {
        digitCounts := make([]int, 10) // Stores counts of digits 0-9 at the current position 'p'

        // Populate digitCounts for the current position
        for _, num := range nums {
            // Extract the digit at the current position 'p'
            // Example: for num=123, p=0 (units), digit = (123 / 1) % 10 = 3
            //          for num=123, p=1 (tens), digit = (123 / 10) % 10 = 2
            //          for num=123, p=2 (hundreds), digit = (123 / 100) % 10 = 1
            //          for num=123, p=3 (thousands), digit = (123 / 1000) % 10 = 0
            digit := (num / currentPowerOf10) % 10
            digitCounts[digit]++
        }

        // Calculate the sum of digit differences for this specific position 'p'
        var positionDiffSum int64 = 0
        for d1 := 0; d1 < 10; d1++ {
            if digitCounts[d1] == 0 {
                continue // No numbers have digit d1 at this position
            }
            for d2 := d1 + 1; d2 < 10; d2++ { // Iterate d2 from d1+1 to avoid duplicate pairs and ensure d2 > d1
                if digitCounts[d2] == 0 {
                    continue // No numbers have digit d2 at this position
                }
                // The contribution of this pair of digits (d1, d2) at this position 'p'
                // is |d1 - d2| * count(d1) * count(d2)
                // Since d2 > d1, |d1 - d2| is simply (d2 - d1)
                positionDiffSum += int64(d2-d1) * int64(digitCounts[d1]) * int64(digitCounts[d2])
            }
        }
        totalSumDiff += positionDiffSum

        // Prepare currentPowerOf10 for the next digit position
        currentPowerOf10 *= 10
    }

    return totalSumDiff
}