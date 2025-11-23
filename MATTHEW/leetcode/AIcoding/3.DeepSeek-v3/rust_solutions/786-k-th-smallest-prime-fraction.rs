use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(PartialEq, Eq)]
struct Fraction {
    numerator: i32,
    denominator: i32,
    value: f64,
}

impl PartialOrd for Fraction {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Fraction {
    fn cmp(&self, other: &Self) -> Ordering {
        self.value.partial_cmp(&other.value).unwrap()
    }
}

impl Solution {
    pub fn kth_smallest_prime_fraction(arr: Vec<i32>, k: i32) -> Vec<i32> {
        let mut heap = BinaryHeap::new();
        let n = arr.len();

        for i in 0..n {
            for j in (i + 1)..n {
                let fraction = Fraction {
                    numerator: arr[i],
                    denominator: arr[j],
                    value: arr[i] as f64 / arr[j] as f64,
                };
                heap.push(fraction);
                if heap.len() > k as usize {
                    heap.pop();
                }
            }
        }

        let result = heap.pop().unwrap();
        vec![result.numerator, result.denominator]
    }
}