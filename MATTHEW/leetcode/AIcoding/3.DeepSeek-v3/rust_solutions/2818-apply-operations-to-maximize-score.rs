use std::collections::BinaryHeap;

const MOD: i64 = 1_000_000_007;

fn max_score(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let k = k as usize;
    let mut primes = vec![0; 100001];
    sieve(&mut primes);

    let mut prime_scores: Vec<i64> = nums.iter().map(|&x| calculate_prime_score(x, &primes)).collect();

    let mut next_greater = vec![n; n];
    let mut prev_greater = vec![n; n];
    let mut stack = Vec::new();

    for i in 0..n {
        while let Some(&top) = stack.last() {
            if prime_scores[i] > prime_scores[top] {
                next_greater[top] = i;
                stack.pop();
            } else {
                break;
            }
        }
        stack.push(i);
    }

    stack.clear();

    for i in (0..n).rev() {
        while let Some(&top) = stack.last() {
            if prime_scores[i] >= prime_scores[top] {
                prev_greater[top] = i;
                stack.pop();
            } else {
                break;
            }
        }
        stack.push(i);
    }

    let mut heap = BinaryHeap::new();
    for i in 0..n {
        let left = i - prev_greater[i];
        let right = next_greater[i] - i;
        let count = left as i64 * right as i64;
        heap.push((prime_scores[i], count));
    }

    let mut result = 1i64;
    let mut remaining = k;

    while remaining > 0 {
        if let Some((score, count)) = heap.pop() {
            let take = count.min(remaining as i64);
            result = (result * mod_pow(score, take)) % MOD;
            remaining -= take as usize;
        }
    }

    result as i32
}

fn sieve(primes: &mut Vec<i32>) {
    for i in 2..primes.len() {
        if primes[i] == 0 {
            primes[i] = i as i32;
            let mut j = i * i;
            while j < primes.len() {
                if primes[j] == 0 {
                    primes[j] = i as i32;
                }
                j += i;
            }
        }
    }
}

fn calculate_prime_score(x: i32, primes: &Vec<i32>) -> i64 {
    if x == 1 {
        return 0;
    }
    let mut x = x as usize;
    let mut distinct_primes = 0;
    let mut last_prime = 0;
    while x > 1 {
        let p = primes[x] as usize;
        if p != last_prime {
            distinct_primes += 1;
            last_prime = p;
        }
        x /= p;
    }
    distinct_primes as i64
}

fn mod_pow(mut base: i64, mut exp: i64) -> i64 {
    let mut result = 1;
    base %= MOD;
    while exp > 0 {
        if exp % 2 == 1 {
            result = (result * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    result
}