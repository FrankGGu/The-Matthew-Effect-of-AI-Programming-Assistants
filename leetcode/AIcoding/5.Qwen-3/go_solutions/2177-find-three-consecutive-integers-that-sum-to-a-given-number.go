package main

func sumOfThree(num int) []int {
    if num%3 != 0 {
        return []int{}
    }
    x := num / 3
    return []int{x - 1, x, x + 1}
}