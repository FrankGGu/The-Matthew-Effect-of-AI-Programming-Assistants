package main

func singleNumber(nums []int) []int {
    xor := 0
    for _, num := range nums {
        xor ^= num
    }

    lowbit := xor & -xor
    a, b := 0, 0
    for _, num := range nums {
        if num&lowbit == 0 {
            a ^= num
        } else {
            b ^= num
        }
    }

    return []int{a, b}
}