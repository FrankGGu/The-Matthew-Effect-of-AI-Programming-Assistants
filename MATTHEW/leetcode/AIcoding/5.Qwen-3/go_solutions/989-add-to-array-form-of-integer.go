package main

func addToArrayForm(num []int, k int) []int {
    for i := len(num) - 1; k > 0; i-- {
        num[i] += k % 10
        k /= 10
        if num[i] >= 10 {
            num[i] -= 10
            k++
        }
        if i == 0 && k > 0 {
            num = append([]int{k}, num...)
            k = 0
        }
    }
    return num
}