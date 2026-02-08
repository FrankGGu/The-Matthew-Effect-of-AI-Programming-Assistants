impl Solution {
    pub fn max_nice_divisors(prime_factors: i32) -> i32 {
        let modulus = 1_000_000_007;

        // The problem asks to maximize the total number of divisors of 'n'.
        // Let n = p1^a1 * p2^a2 * ... * pk^ak, where p_i are distinct primes.
        // The total number of prime factors (counted with multiplicity) is a1 + a2 + ... + ak = primeFactors.
        // The total number of divisors of n is (a1+1)(a2+1)...(ak+1).
        // We want to maximize this product subject to sum(ai) = primeFactors and ai >= 1.

        // Consider a single exponent 'a'. Its contribution to the product is (a+1).
        // If we break 'a' into 'a' ones (i.e., replace p^a with p1*p2*...*pa),
        // the sum of exponents is still 'a' (1+1+...+1 = a).
        // The contribution to the product becomes (1+1)(1+1)...(1+1) = 2^a.
        // We compare (a+1) with 2^a.
        // For a=1: 1+1 = 2, 2^1 = 2. (Equal)
        // For a=2: 2+1 = 3, 2^2 = 4. (2^a is greater)
        // For a=3: 3+1 = 4, 2^3 = 8. (2^a is greater)
        // In general, for a >= 1, 2^a >= a+1.
        // This means it is always optimal to break down any exponent 'a' into 'a' separate prime factors, each with an exponent of 1.
        // For example, if we have p^4, its contribution is (4+1)=5.
        // If we replace it with p1*p2*p3*p4, the sum of exponents is 1+1+1+1=4.
        // The contribution is (1+1)(1+1)(1+1)(1+1) = 2*2*2*2 = 16.
        // Since 16 > 5, breaking down is better.

        // Therefore, to maximize the total number of divisors, we should make all exponents a_i equal to 1.
        // This means n should be a product of 'primeFactors' distinct prime numbers, each raised to the power of 1.
        // For example, if primeFactors = 5, n = 2 * 3 * 5 * 7 * 11.
        // The sum of exponents is 1+1+1+1+1 = 5.
        // The total number of divisors is (1+1)(1+1)(1+1)(1+1)(1+1) = 2 * 2 * 2 * 2 * 2 = 2^5 = 32.

        // The problem then reduces to calculating 2 raised to the power of primeFactors, modulo 10^9 + 7.

        let mut base: i64 = 2;
        let mut exp: i64 = prime_factors as i64;
        let mut res: i64 = 1;

        base %= modulus;

        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }

        res as i32
    }
}