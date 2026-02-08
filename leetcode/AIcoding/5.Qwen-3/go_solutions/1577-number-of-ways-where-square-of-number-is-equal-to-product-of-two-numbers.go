package main

func numTriplets(nums1 []int, nums2 []int) int {
    count := 0
    freq1 := make(map[int]int)
    freq2 := make(map[int]int)

    for _, num := range nums1 {
        freq1[num]++
    }

    for _, num := range nums2 {
        freq2[num]++
    }

    for _, num1 := range nums1 {
        square := num1 * num1
        for key, val := range freq2 {
            if square%key == 0 {
                count += val * freq1[square/key]
            }
        }
    }

    return count
}