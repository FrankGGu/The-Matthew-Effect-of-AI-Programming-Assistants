func canFormStableArray(arr []int) bool {
    n := len(arr)
    count := make([]int, n)

    for _, num := range arr {
        count[num]++
    }

    for i := 0; i < n; i++ {
        if count[i] == 0 {
            return false
        }
    }

    return true
}

func findStableArrays(n int) [][]int {
    result := [][]int{}
    arr := make([]int, n)

    var backtrack func(index int)
    backtrack = func(index int) {
        if index == n {
            if canFormStableArray(arr) {
                temp := make([]int, n)
                copy(temp, arr)
                result = append(result, temp)
            }
            return
        }
        for i := 0; i < n; i++ {
            arr[index] = i
            backtrack(index + 1)
        }
    }

    backtrack(0)
    return result
}

func stableBinaryArrays(n int) [][]int {
    return findStableArrays(n)
}