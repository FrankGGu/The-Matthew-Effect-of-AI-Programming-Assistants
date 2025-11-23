package main

func findNthDigit(n int) int {
    length := 1
    count := 9
    start := 1

    for n > length*count {
        n -= length * count
        length++
        count *= 10
        start *= 10
    }

    number := start + (n-1)/length
    return int(strconv.Itoa(number)[(n-1)%length])
}