package main

import (
	"math"
)

var globalX int
var memo map[int]int

func leastOpsExpressTarget(x_param int, target int) int {
	globalX = x_param
	memo = make(map[int]int)
	return solve(target)
}

func solve(target int) int {
	if target == 0 {
		return 0
	}
	if target == 1 {
		// As per problem constraints, x >= 2.
		// So 1 must be expressed as x/x, which costs 2 operators.
		return 2
	}

	if val, ok := memo[target]; ok {
		return val
	}

	ans := math.MaxInt32

	// Find largest k such that globalX^k <= target
	// k_val_pow represents globalX^k
	// k_ops_count represents the cost of globalX^k (which is k)
	k_val_pow := 1     // Starts at globalX^0 = 1
	k_ops_count := 0   // Cost for globalX^0 (conceptually 0, but handled specially for 1)

	// Iterate to find the largest globalX^k <= target
	// k_val_pow must be <= target / globalX to prevent overflow when k_val_pow * globalX
	for k_val_pow <= target/globalX {
		k_val_pow *= globalX
		k_ops_count++
	}

	// Option 1: target = q * k_val_pow + r
	// This represents target as (k_val_pow + k_val_pow + ... + k_val_pow) + r
	q := target / k_val_pow
	r := target % k_val_pow

	currentCost1 := 0
	if k_ops_count == 0 { // This means k_val_pow is 1 (globalX^0)
		// q terms of 1, plus (q-1) additions, plus solve(r)
		// Cost of 1 is solve(1) = 2
		currentCost1 = q*solve(1) + (q-1) + solve(r)
	} else {
		// q terms of globalX^k_ops_count, plus (q-1) additions, plus solve(r)
		currentCost1 = q*k_ops_count + (q-1) + solve(r)
	}
	ans = min(ans, currentCost1)

	// Option 2: target = (q+1) * k_val_pow - r_prime
	// This represents target as (k_val_pow + ... + k_val_pow) - r_prime
	r_prime := (q+1)*k_val_pow - target

	currentCost2 := 0
	if k_ops_count == 0 { // This means k_val_pow is 1 (globalX^0)
		// (q+1) terms of 1, plus q additions, plus solve(r_prime)
		// Cost of 1 is solve(1) = 2
		currentCost2 = (q+1)*solve(1) + q + solve(r_prime)
	} else {
		// (q+1) terms of globalX^k_ops_count, plus q additions, plus solve(r_prime)
		currentCost2 = (q+1)*k_ops_count + q + solve(r_prime)
	}
	ans = min(ans, currentCost2)

	memo[target] = ans
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}