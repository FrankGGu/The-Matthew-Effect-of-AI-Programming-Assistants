func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}

func countSubsequences(nums []int, targetGcd int) int {
    n := len(nums)
    mod := int(1e9 + 7)

    // Step 1: Count the occurrences of each number
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    // Step 2: Iterate through the numbers and check for valid GCD
    result := 0
    for g := 1; g <= targetGcd; g++ {
        if targetGcd%g == 0 {
            currentGcd := 0
            totalCount := 0
            for num, cnt := range count {
                if num%g == 0 {
                    currentGcd = gcd(currentGcd, num/g)
                    totalCount += cnt
                }
            }
            if currentGcd == targetGcd/g {
                result = (result + pow(2, totalCount, mod) - 1) % mod
            }
        }
    }

    return result
}

func pow(x, y, p int) int {
    res := 1
    x = x % p
    if x == 0 {
        return 0
    }
    for y > 0 {
        if y&1 == 1 {
            res = (res * x) % p
        }
        y = y >> 1
        x = (x * x) % p
    }
    return res
}

func numOfSubseq(nums []int, targetGcd int) int {
    return countSubsequences(nums, targetGcd)
}