use std::collections::{HashSet, HashMap};

fn sieve_of_eratosthenes(limit: i32) -> Vec<i32> {
    let mut is_prime = vec![true; (limit + 1) as usize];
    is_prime[0] = false;
    is_prime[1] = false;
    for p in 2..=(limit as f64).sqrt() as i32 {
        if is_prime[p as usize] {
            for multiple in (p * p..=limit).step_by(p as usize) {
                is_prime[multiple as usize] = false;
            }
        }
    }
    is_prime.iter().enumerate().filter_map(|(i, &prime)| {
        if prime { Some(i as i32) } else { None }
    }).collect()
}

fn get_distinct_prime_factors(mut n: i32, primes: &[i32]) -> HashSet<i32> {
    let mut factors = HashSet::new();
    for &p in primes {
        if p * p > n {
            break;
        }
        if n % p == 0 {
            factors.insert(p);
            while n % p == 0 {
                n /= p;
            }
        }
    }
    if n > 1 {
        factors.insert(n);
    }
    factors
}

impl Solution {
    pub fn maximize_distinct_prime_factors(nums: Vec<i32>) -> i32 {
        let max_val = 1000;
        let primes = sieve_of_eratosthenes(max_val);

        let mut all_num_prime_factors: Vec<HashSet<i32>> = vec![HashSet::new(); max_val as usize + 1];
        for i in 2..=max_val {
            all_num_prime_factors[i as usize] = get_distinct_prime_factors(i, &primes);
        }

        let n = nums.len();
        let mut prefix_prime_counts: HashMap<i32, i32> = HashMap::new();
        let mut suffix_prime_counts: HashMap<i32, i32> = HashMap::new();

        for &num in &nums {
            for &p in &all_num_prime_factors[num as usize] {
                *suffix_prime_counts.entry(p).or_insert(0) += 1;
            }
        }

        let mut max_score = 0;

        for i in 0..n - 1 {
            let current_num = nums[i];

            for &p in &all_num_prime_factors[current_num as usize] {
                *prefix_prime_counts.entry(p).or_insert(0) += 1;
                *suffix_prime_counts.entry(p).or_insert(0) -= 1;
                if *suffix_prime_counts.get(&p).unwrap() == 0 {
                    suffix_prime_counts.remove(&p);
                }
            }

            let current_score = prefix_prime_counts.len() + suffix_prime_counts.len();
            if current_score > max_score {
                max_score = current_score;
            }
        }

        max_score
    }
}