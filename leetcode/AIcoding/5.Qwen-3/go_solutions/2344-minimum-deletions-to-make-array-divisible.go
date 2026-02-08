package main

func minDeletions(nums []int, numsDivide []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    sort.Ints(numsDivide)

    for i := 0; i < len(numsDivide); i++ {
        if i > 0 && numsDivide[i] == numsDivide[i-1] {
            continue
        }
        target := numsDivide[i]
        count := 0
        for k := range freq {
            if k%target != 0 {
                count += freq[k]
            }
        }
        if count == 0 {
            return 0
        }
        if i == 0 {
            minDel := count
            for j := 1; j < len(numsDivide); j++ {
                if numsDivide[j] != numsDivide[j-1] {
                    target = numsDivide[j]
                    count = 0
                    for k := range freq {
                        if k%target != 0 {
                            count += freq[k]
                        }
                    }
                    if count < minDel {
                        minDel = count
                    }
                }
            }
            return minDel
        }
    }
    return -1
}