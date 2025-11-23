import (
	"sort"
)

func sumDistance(nums []int, s string, d int) int {
	n := len(nums)
	pos := make([]int, n)
	for i := 0; i < n; i++ {
		if s[i] == 'L' {
			pos[i] = nums[i] - d
		} else {
			pos[i] = nums[i] + d
		}
	}
	sort.Ints(pos)
	ans := 0
	mod := 1000000007
	for i := 1; i < n; i++ {
		ans = (ans + pos[i] - pos[i-1]) % mod
	}
	pref := make([]int, n)
	pref[0] = pos[0]
	for i := 1; i < n; i++ {
		pref[i] = (pref[i-1] + pos[i]) % mod
	}
	res := 0
	for i := 0; i < n; i++ {
		if i > 0 {
			res = (res + (i*pos[i] - pref[i-1] + mod) % mod) % mod
		} else {
			res = res % mod
		}
		if i < n-1 {
			res = (res + (pref[n-1] - pref[i] + mod) % mod - (n-1-i)*pos[i]%mod + mod) % mod
		} else {
			res = res % mod
		}
	}
	res = 0
	for i := 1; i < n; i++ {
		res = (res + abs(pos[i] - pos[i-1])) % mod
	}

	res = 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			res = (res + abs(pos[i] - pos[j])) % mod
		}
	}

	res = 0
	sort.Ints(pos)
	for i := 1; i < n; i++ {
		res = (res + abs(pos[i] - pos[i-1])) % mod
	}

	res = 0
	sum := 0
	for i := 0; i < n; i++ {
		res = (res + abs(pos[i] - sum)) % mod
		sum = (sum + pos[i]) % mod
	}

	res = 0
	sort.Ints(pos)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			res = (res + abs(pos[i] - pos[j])) % mod
		}
	}

	return res
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}