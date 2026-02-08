func wiggleSort(nums []int)  {
    n := len(nums)
    temp := make([]int, n)
    copy(temp, nums)
    sort.Ints(temp)

    i := (n + 1) / 2 - 1
    j := n - 1

    for k := 0; k < n; k++ {
        if k % 2 == 0 {
            nums[k] = temp[i]
            i--
        } else {
            nums[k] = temp[j]
            j--
        }
    }
}