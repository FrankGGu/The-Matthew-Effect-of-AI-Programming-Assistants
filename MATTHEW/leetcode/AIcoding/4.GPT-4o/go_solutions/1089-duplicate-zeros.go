func duplicateZeros(arr []int) {
    n := len(arr)
    countZeros := 0

    for _, num := range arr {
        if num == 0 {
            countZeros++
        }
    }

    for i := n - 1; i >= 0; i-- {
        if arr[i] == 0 {
            countZeros--
            if i+countZeros < n {
                arr[i+countZeros] = 0
            }
            if i+countZeros+1 < n {
                arr[i+countZeros+1] = 0
            }
        } else if i+countZeros < n {
            arr[i+countZeros] = arr[i]
        }
    }
}