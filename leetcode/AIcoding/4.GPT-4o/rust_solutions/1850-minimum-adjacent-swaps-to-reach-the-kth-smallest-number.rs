impl Solution {
    pub fn get_min_swaps(num: String, k: i32) -> i32 {
        let mut digits: Vec<char> = num.chars().collect();
        let mut target = digits.clone();
        for _ in 0..k {
            let mut next = digits.clone();
            let mut i = next.len() - 1;
            while i > 0 {
                if next[i] > next[i - 1] {
                    break;
                }
                i -= 1;
            }
            if i == 0 {
                break;
            }
            let mut j = next.len() - 1;
            while next[j] <= next[i - 1] {
                j -= 1;
            }
            next.swap(i - 1, j);
            next[i..].reverse();
            target = next;
            digits = target.clone();
        }
        let mut swaps = 0;
        let mut i = 0;
        while i < digits.len() {
            if digits[i] != target[i] {
                let mut j = i + 1;
                while digits[j] != target[i] {
                    j += 1;
                }
                while j > i {
                    digits.swap(j, j - 1);
                    j -= 1;
                    swaps += 1;
                }
            }
            i += 1;
        }
        swaps
    }
}