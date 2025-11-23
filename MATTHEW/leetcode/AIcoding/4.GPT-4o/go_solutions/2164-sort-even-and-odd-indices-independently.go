func sortEvenOdd(nums []int) []int {
    even := []int{}
    odd := []int{}

    for i, num := range nums {
        if i%2 == 0 {
            even = append(even, num)
        } else {
            odd = append(odd, num)
        }
    }

    sort.Ints(even)
    sort.Sort(sort.Reverse(sort.IntSlice(odd)))

    result := make([]int, len(nums))
    for i := 0; i < len(nums); i++ {
        if i%2 == 0 {
            result[i] = even[i/2]
        } else {
            result[i] = odd[i/2]
        }
    }

    return result
}