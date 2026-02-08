func beautySum(s string) int {
    totalBeauty := 0
    n := len(s)

    for i := 0; i < n; i++ {
        freq := make([]int, 26)
        maxFreq, minFreq := 0, math.MaxInt32

        for j := i; j < n; j++ {
            charIndex := s[j] - 'a'
            freq[charIndex]++
            if freq[charIndex] > maxFreq {
                maxFreq = freq[charIndex]
            }
            if freq[charIndex] < minFreq && freq[charIndex] > 0 {
                minFreq = freq[charIndex]
            }

            if minFreq != math.MaxInt32 {
                totalBeauty += maxFreq - minFreq
            }
        }
    }

    return totalBeauty
}