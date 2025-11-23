package main

func totalFruit(fruits []int) int {
    left := 0
    maxFruits := 0
    fruitCount := make(map[int]int)

    for right := 0; right < len(fruits); right++ {
        fruitCount[fruits[right]]++

        for len(fruitCount) > 2 {
            leftFruit := fruits[left]
            fruitCount[leftFruit]--
            if fruitCount[leftFruit] == 0 {
                delete(fruitCount, leftFruit)
            }
            left++
        }

        if right-left+1 > maxFruits {
            maxFruits = right - left + 1
        }
    }

    return maxFruits
}