package main

func totalFruit(tree []int) int {
    if len(tree) < 2 {
        return len(tree)
    }

    left := 0
    maxFruits := 0
    fruitCount := make(map[int]int)

    for right := 0; right < len(tree); right++ {
        fruitCount[tree[right]]++

        for len(fruitCount) > 2 {
            fruitCount[tree[left]]--
            if fruitCount[tree[left]] == 0 {
                delete(fruitCount, tree[left])
            }
            left++
        }

        if right-left+1 > maxFruits {
            maxFruits = right - left + 1
        }
    }

    return maxFruits
}