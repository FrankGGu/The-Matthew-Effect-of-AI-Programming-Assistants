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

        maxFruits = max(maxFruits, right-left+1)
    }

    return maxFruits
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}