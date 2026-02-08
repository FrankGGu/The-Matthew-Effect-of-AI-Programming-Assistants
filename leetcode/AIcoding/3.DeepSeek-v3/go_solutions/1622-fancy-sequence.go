type Fancy struct {
    arr []int
    add int
    mul int
}

func Constructor() Fancy {
    return Fancy{
        arr: make([]int, 0),
        add: 0,
        mul: 1,
    }
}

func (this *Fancy) Append(val int) {
    val = (val - this.add + MOD) % MOD
    val = (val * modInverse(this.mul, MOD)) % MOD
    this.arr = append(this.arr, val)
}

func (this *Fancy) AddAll(inc int) {
    this.add = (this.add + inc) % MOD
}

func (this *Fancy) MultAll(m int) {
    this.add = (this.add * m) % MOD
    this.mul = (this.mul * m) % MOD
}

func (this *Fancy) GetIndex(idx int) int {
    if idx >= len(this.arr) {
        return -1
    }
    val := (this.arr[idx]*this.mul + this.add) % MOD
    return val
}

const MOD = 1e9 + 7

func modInverse(a, mod int) int {
    return pow(a, mod-2, mod)
}

func pow(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b&1 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b >>= 1
    }
    return res
}