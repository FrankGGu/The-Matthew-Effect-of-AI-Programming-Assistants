func numTriplets(nums1 []int, nums2 []int) int {
    count := 0
    count += helper(nums1, nums2)
    count += helper(nums2, nums1)
    return count
}

func helper(a []int, b []int) int {
    res := 0
    freq := make(map[int]int)
    for _, num := range b {
        freq[num]++
    }
    for _, x := range a {
        target := x * x
        for y, cnt := range freq {
            if target%y != 0 {
                continue
            }
            z := target / y
            if z < y {
                continue
            }
            if _, exists := freq[z]; exists {
                if y == z {
                    res += cnt * (cnt - 1) / 2
                } else {
                    res += cnt * freq[z]
                }
            }
        }
    }
    return res
}