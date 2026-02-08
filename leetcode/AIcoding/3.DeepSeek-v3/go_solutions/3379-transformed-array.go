func transformArray(arr []int) []int {
    changed := true
    for changed {
        changed = false
        newArr := make([]int, len(arr))
        copy(newArr, arr)
        for i := 1; i < len(arr)-1; i++ {
            if arr[i] < arr[i-1] && arr[i] < arr[i+1] {
                newArr[i]++
                changed = true
            } else if arr[i] > arr[i-1] && arr[i] > arr[i+1] {
                newArr[i]--
                changed = true
            }
        }
        arr = newArr
    }
    return arr
}