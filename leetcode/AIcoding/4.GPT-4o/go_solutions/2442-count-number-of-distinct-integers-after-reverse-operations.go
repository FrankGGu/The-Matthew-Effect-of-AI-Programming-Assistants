func countDistinctIntegers(A []int) int {
    distinct := make(map[int]struct{})

    for _, num := range A {
        distinct[num] = struct{}{}
        reversed := reverse(num)
        distinct[reversed] = struct{}{}
    }

    return len(distinct)
}

func reverse(n int) int {
    rev := 0
    for n > 0 {
        rev = rev*10 + n%10
        n /= 10
    }
    return rev
}