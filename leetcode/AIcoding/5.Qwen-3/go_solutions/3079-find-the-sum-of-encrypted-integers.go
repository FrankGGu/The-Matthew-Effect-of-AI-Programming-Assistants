package main

func sumOfEncryptedInt(nums []int) int {
    sum := 0
    for _, num := range nums {
        s := strconv.Itoa(num)
        n := len(s)
        encrypted := 0
        for i := 0; i < n; i++ {
            encrypted = encrypted * 10 + int(s[i]-'0')
        }
        sum += encrypted
    }
    return sum
}