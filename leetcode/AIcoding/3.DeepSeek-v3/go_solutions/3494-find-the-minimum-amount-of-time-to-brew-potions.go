import "sort"

func minTimeToBrew(potions []int, target int) int {
    sort.Ints(potions)
    left, right := 1, potions[len(potions)-1]*target
    result := right

    for left <= right {
        mid := left + (right-left)/2
        total := 0
        for _, p := range potions {
            total += mid / p
            if total >= target {
                break
            }
        }
        if total >= target {
            result = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return result
}