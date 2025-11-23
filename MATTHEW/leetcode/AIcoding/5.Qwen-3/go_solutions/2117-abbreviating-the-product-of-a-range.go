package main

func abbreviationDistance(nums []int, startInd int, endInd int) string {
    var product [10]int
    for i := 0; i < 10; i++ {
        product[i] = 1
    }
    for i := startInd; i <= endInd; i++ {
        num := nums[i]
        for j := 0; j < 10; j++ {
            product[j] *= num % 10
            num /= 10
        }
    }
    for i := 0; i < 10; i++ {
        if product[i] == 0 {
            product[i] = 1
        }
    }
    for i := 0; i < 10; i++ {
        for product[i] > 9 {
            product[i] /= 10
        }
    }
    var result string
    for i := 0; i < 10; i++ {
        result += strconv.Itoa(product[i])
    }
    return result
}