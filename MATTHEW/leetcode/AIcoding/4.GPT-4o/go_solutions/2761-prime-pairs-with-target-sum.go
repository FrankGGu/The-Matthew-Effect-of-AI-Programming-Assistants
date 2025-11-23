func primePairs(target int) [][]int {
    isPrime := make([]bool, target+1)
    for i := 2; i <= target; i++ {
        isPrime[i] = true
    }
    for i := 2; i*i <= target; i++ {
        if isPrime[i] {
            for j := i * i; j <= target; j += i {
                isPrime[j] = false
            }
        }
    }

    var result [][]int
    for i := 2; i <= target/2; i++ {
        if isPrime[i] && isPrime[target-i] {
            result = append(result, []int{i, target - i})
        }
    }
    return result
}