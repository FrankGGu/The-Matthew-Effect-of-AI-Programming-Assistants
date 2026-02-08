func totalFruit(fruits []int) int {
    maxFruits := 0
    basket := make(map[int]int)
    left := 0

    for right := 0; right < len(fruits); right++ {
        basket[fruits[right]]++

        for len(basket) > 2 {
            basket[fruits[left]]--
            if basket[fruits[left]] == 0 {
                delete(basket, fruits[left])
            }
            left++
        }

        if right-left+1 > maxFruits {
            maxFruits = right - left + 1
        }
    }

    return maxFruits
}