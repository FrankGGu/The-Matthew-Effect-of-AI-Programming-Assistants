type RangeProductQueries struct {
    prefix []int64
    mod    int64
}

func Constructor(nums []int) RangeProductQueries {
    mod := int64(1e9 + 7)
    prefix := make([]int64, len(nums)+1)
    for i := 1; i <= len(nums); i++ {
        prefix[i] = (prefix[i-1] * int64(nums[i-1])) % mod
    }
    return RangeProductQueries{prefix: prefix, mod: mod}
}

func (this *RangeProductQueries) Product(l int, r int) int {
    if l == 0 {
        return int(this.prefix[r+1])
    }
    return int((this.prefix[r+1] * pow(this.prefix[l], this.mod-2, this.mod)) % this.mod)
}

func pow(x, n, mod int64) int64 {
    res := int64(1)
    x = x % mod
    for n > 0 {
        if n%2 == 1 {
            res = (res * x) % mod
        }
        x = (x * x) % mod
        n /= 2
    }
    return res
}