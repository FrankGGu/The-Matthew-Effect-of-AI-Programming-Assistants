func largestInteger(num int) int {
    even, odd := []int{}, []int{}
    for num > 0 {
        digit := num % 10
        if digit%2 == 0 {
            even = append(even, digit)
        } else {
            odd = append(odd, digit)
        }
        num /= 10
    }

    sort.Sort(sort.Reverse(sort.IntSlice(even)))
    sort.Sort(sort.Reverse(sort.IntSlice(odd)))

    result := 0
    for i := 0; i < len(even) || i < len(odd); i++ {
        if i < len(even) {
            result = result*10 + even[i]
        }
        if i < len(odd) {
            result = result*10 + odd[i]
        }
    }

    return result
}