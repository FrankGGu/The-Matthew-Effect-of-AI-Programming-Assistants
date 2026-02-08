type Fancy struct {
	nums     []int // Stores base values
	global_m int   // Current global multiplier
	global_a int   // Current global adder
	MOD      int
}

func Constructor() Fancy {
	return Fancy{
		nums:     make([]int, 0),
		global_m: 1,
		global_a: 0,
		MOD:      1_000_000_007,
	}
}

func (this *Fancy) Append(val int) {
	var base_val int
	if this.global_m == 0 {
		// If global_m is 0, all numbers effectively become global_a.
		// So, the appended 'val' must be equal to 'global_a' for consistency.
		// In this case, any base_val will result in 'global_a' when transformed (base_val * 0 + global_a = global_a).
		// We can store 0 as the base_val.
		base_val = 0
	} else {
		// We want to find base_val such that:
		// val = base_val * global_m + global_a (mod MOD)
		// base_val = (val - global_a) * modInverse(global_m) (mod MOD)
		inv_m := this.modInverse(this.global_m)
		base_val = (val - this.global_a + this.MOD) % this.MOD // Ensure positive result before multiplication
		base_val = (base_val * inv_m) % this.MOD
	}
	this.nums = append(this.nums, base_val)
}

func (this *Fancy) AddAll(inc int) {
	this.global_a = (this.global_a + inc) % this.MOD
}

func (this *Fancy) MultAll(mult int) {
	this.global_m = (this.global_m * mult) % this.MOD
	this.global_a = (this.global_a * mult) % this.MOD
}

func (this *Fancy) GetIndex(idx int) int {
	if idx >= len(this.nums) {
		return -1
	}
	base_val := this.nums[idx]
	// The final value is base_val * global_m + global_a (mod MOD)
	result := (base_val*this.global_m + this.global_a) % this.MOD
	return result
}

func (this *Fancy) pow(base, exp int) int {
	res := 1
	base %= this.MOD
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % this.MOD
		}
		base = (base * base) % this.MOD
		exp /= 2
	}
	return res
}

func (this *Fancy) modInverse(n int) int {
	return this.pow(n, this.MOD-2)
}