package main

import (
	"fmt"
	"math"
)

const MOD = 1e9 + 7

type Matrix [][]int

func (A Matrix) Mul(B Matrix) Matrix {
	rowsA := len(A)
	colsA := len(A[0])
	rowsB := len(B)
	colsB := len(B[0])

	result := make(Matrix, rowsA)
	for i := 0; i < rowsA; i++ {
		result[i] = make([]int, colsB)
		for j := 0; j < colsB; j++ {
			for l := 0; l < colsA; l++ {
				result[i][j] = (result[i][j] + A[i][l]*B[l][j]) % MOD
			}
		}
	}
	return result
}

func (A Matrix) Power(pow int) Matrix {
	rows := len(A)
	result := make(Matrix, rows)
	for i := 0; i < rows; i++ {
		result[i] = make([]int, rows)
		result[i][i] = 1 // Identity matrix
	}

	base := A
	for pow > 0 {
		if pow%2 == 1 {
			result = result.Mul(base)
		}
		base = base.Mul(base)
		pow /= 2
	}
	return result
}

func power(base, exp int) int {
	res := 1
	base %= MOD
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % MOD
		}
		base = (base * base) % MOD
		exp /= 2
	}
	return res
}

func findSumOfArrayProduct(n int, k int) int {
	if k == 0 {
		return 0
	}

	// spf[i] stores the smallest prime factor of i
	spf := make([]int, n+1)
	primes := []int{}
	for i := 0; i <= n; i++ {
		spf[i] = i
	}
	for i := 2; i <= n; i++ {
		if spf[i] == i { // i is prime
			primes = append(primes, i)
			for j := i * i; j <= n; j += i {
				if spf[j] == j { // Only update if not already marked by a smaller prime
					spf[j] = i
				}
			}
		}
	}

	// f_val[j] stores j * Q_k(j)
	// Q_k(j) is the sum of products of (a_0 * ... * a_{k-2}) for sequences ending in j
	// Q_k(j) is multiplicative.
	f_val := make([]int, n+1)
	f_val[1] = 1 // Q_k(1) = 1 for any k >= 1, so 1 * Q_k(1) = 1

	// Iterate through primes to compute f_val[p^a]
	for _, p := range primes {
		// Calculate max exponent 'a' for p such that p^a <= n
		maxA := int(math.Log(float64(n)) / math.Log(float64(p)))

		// Matrix size is (maxA + 1) x (maxA + 1)
		matrixSize := maxA + 1
		M := make(Matrix, matrixSize)
		for i := 0; i < matrixSize; i++ {
			M[i] = make([]int, matrixSize)
			for j := 0; j <= i; j++ { // M[i][j] = p^j if j <= i, 0 otherwise
				M[i][j] = power(p, j)
			}
		}

		var M_pow_k_minus_1 Matrix
		if k == 1 {
			// If k=1, M^(k-1) is identity matrix
			M_pow_k_minus_1 = make(Matrix, matrixSize)
			for i := 0; i < matrixSize; i++ {
				M_pow_k_minus_1[i] = make([]int, matrixSize)
				M_pow_k_minus_1[i][i] = 1
			}
		} else {
			M_pow_k_minus_1 = M.Power(k - 1)
		}

		// V_1 = [Q_1(p^0), Q_1(p^1), ..., Q_1(p^A)]^T
		// Q_1(j) = 1 for all j
		V1 := make([]int, matrixSize)
		for a := 0; a <= maxA; a++ {
			V1[a] = 1
		}

		// V_k = M_pow_k_minus_1 * V_1
		// V_k is a column vector, so perform matrix-vector multiplication
		Vk := make([]int, matrixSize)
		for i := 0; i < matrixSize; i++ {
			for j := 0; j < matrixSize; j++ {
				Vk[i] = (Vk[i] + M_pow_k_minus_1[i][j]*V1[j]) % MOD
			}
		}

		// Store f_val[p^a] = p^a * Q_k(p^a)
		current_p_pow := 1
		for a := 0; a <= maxA; a++ {
			f_val[current_p_pow] = (current_p_pow * Vk[a]) % MOD
			if a < maxA {
				if current_p_pow > n/p { // Check for overflow before multiplying
					break
				}
				current_p_pow *= p
			}
		}
	}

	// Compute f_val[j] for composite j using multiplicative property
	// f(j) = j * Q_k(j) is multiplicative
	for i := 2; i <= n; i++ {
		if f_val[i] == 0 { // If f_val[i] is not a prime power already computed
			p := spf[i]
			p_pow_a := p
			val_i_div_p_pow_a := i / p
			for val_i_div_p_pow_a%p == 0 {
				p_pow_a *= p
				val_i_div_p_pow_a /= p
			}
			f_val[i] = (f_val[p_pow_a] * f_val[val_i_div_p_pow_a]) % MOD
		}
	}

	// Sum all f_val[j]
	totalSum := 0
	for i := 1; i <= n; i++ {
		totalSum = (totalSum + f_val[i]) % MOD
	}

	return totalSum
}