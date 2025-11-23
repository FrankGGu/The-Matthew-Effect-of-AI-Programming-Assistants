func maxDiffEvenOddFrequency(nums []int) int {
    evenFreq := make(map[int]int)
    oddFreq := make(map[int]int)

    for _, num := range nums {
        if num % 2 == 0 {
            evenFreq[num]++
        } else {
            oddFreq[num]++
        }
    }

    maxEven := 0
    for _, freq := range evenFreq {
        if freq > maxEven {
            maxEven = freq
        }
    }

    maxOdd := 0
    for _, freq := range oddFreq {
        if freq > maxOdd {
            maxOdd = freq
        }
    }

    if maxEven == 0 || maxOdd == 0 {
        return -1
    }

    return maxEven - maxOdd
}