func maxDiff(nums []int) int {
    n := len(nums)
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    evenFreq := make(map[int]int)
    oddFreq := make(map[int]int)
    for num, f := range freq {
        if f%2 == 0 {
            evenFreq[num] = f
        } else {
            oddFreq[num] = f
        }
    }

    evenNums := make([]int, 0, len(evenFreq))
    oddNums := make([]int, 0, len(oddFreq))
    for num := range evenFreq {
        evenNums = append(evenNums, num)
    }
    for num := range oddFreq {
        oddNums = append(oddNums, num)
    }

    maxSum := 0
    for i := 0; i < (1 << len(evenNums)); i++ {
        for j := 0; j < (1 << len(oddNums)); j++ {
            currSum := 0
            for k := 0; k < len(evenNums); k++ {
                if (i>>k)&1 == 1 {
                    currSum += evenFreq[evenNums[k]]
                } else {
                    currSum -= evenFreq[evenNums[k]]
                }
            }
            for k := 0; k < len(oddNums); k++ {
                if (j>>k)&1 == 1 {
                    currSum += oddFreq[oddNums[k]]
                } else {
                    currSum -= oddFreq[oddNums[k]]
                }
            }
            if currSum > maxSum {
                maxSum = currSum
            }
        }
    }

    return maxSum
}