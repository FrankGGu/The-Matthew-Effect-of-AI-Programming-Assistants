impl Solution {
    pub fn get_probability(box1: Vec<i32>, box2: Vec<i32>) -> f64 {
        use std::collections::HashMap;

        let n1 = box1.len();
        let n2 = box2.len();
        let total = n1 + n2;

        let mut count1 = HashMap::new();
        let mut count2 = HashMap::new();

        for &b in &box1 {
            *count1.entry(b).or_insert(0) += 1;
        }
        for &b in &box2 {
            *count2.entry(b).or_insert(0) += 1;
        }

        let distinct1 = count1.len();
        let distinct2 = count2.len();

        if distinct1 != distinct2 {
            return 0.0;
        }

        let mut total_ways = 0.0;
        let mut same_ways = 0.0;

        for i in 0..=total {
            let mut comb1 = 1;
            let mut comb2 = 1;

            for &c in count1.values() {
                comb1 *= binom(n1, c);
                n1 -= c;
            }

            for &c in count2.values() {
                comb2 *= binom(n2, c);
                n2 -= c;
            }

            total_ways += comb1 * comb2;
            if comb1 == comb2 {
                same_ways += comb1 * comb2;
            }
        }

        same_ways / total_ways
    }
}

fn binom(n: usize, k: usize) -> f64 {
    if k > n {
        return 0.0;
    }
    (factorial(n) / (factorial(k) * factorial(n - k))) as f64
}

fn factorial(n: usize) -> f64 {
    (1..=n).product::<usize>() as f64
}