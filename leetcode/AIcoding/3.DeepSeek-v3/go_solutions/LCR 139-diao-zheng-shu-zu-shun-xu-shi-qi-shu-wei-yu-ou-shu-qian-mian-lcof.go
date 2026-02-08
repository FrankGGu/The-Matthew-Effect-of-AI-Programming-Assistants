func trainingPlan(actions []int) []int {
    left, right := 0, len(actions)-1
    for left < right {
        for left < right && actions[left]%2 == 1 {
            left++
        }
        for left < right && actions[right]%2 == 0 {
            right--
        }
        if left < right {
            actions[left], actions[right] = actions[right], actions[left]
            left++
            right--
        }
    }
    return actions
}