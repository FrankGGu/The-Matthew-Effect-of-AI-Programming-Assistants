func minimumOperations(nums []int) int {
    if len(nums) <= 1 {
        return 0
    }

    evenFreq := make(map[int]int)
    oddFreq := make(map[int]int)

    for i := 0; i < len(nums); i++ {
        if i%2 == 0 {
            evenFreq[nums[i]]++
        } else {
            oddFreq[nums[i]]++
        }
    }

    evenMax1, evenMax2 := getTopTwo(evenFreq)
    oddMax1, oddMax2 := getTopTwo(oddFreq)

    if evenMax1.num != oddMax1.num {
        return len(nums) - evenMax1.count - oddMax1.count
    }

    option1 := len(nums) - evenMax1.count - oddMax2.count
    option2 := len(nums) - evenMax2.count - oddMax1.count

    if option1 < option2 {
        return option1
    }
    return option2
}

type freq struct {
    num   int
    count int
}

func getTopTwo(freqMap map[int]int) (freq, freq) {
    max1 := freq{-1, 0}
    max2 := freq{-1, 0}

    for num, count := range freqMap {
        if count > max1.count {
            max2 = max1
            max1 = freq{num, count}
        } else if count > max2.count {
            max2 = freq{num, count}
        }
    }

    return max1, max2
}