impl Solution {
    pub fn can_arrange(arr: Vec<i32>, k: i32) -> bool {
        let mut remainders = vec![0; k as usize];
        for &num in &arr {
            let remainder = (num % k + k) % k;
            remainders[remainder as usize] += 1;
        }

        if remainders[0] % 2 != 0 {
            return false;
        }

        for i in 1..(k as usize + 1) / 2 {
            if remainders[i] != remainders[(k - i as i32) as usize] {
                return false;
            }
        }

        if k % 2 == 0 && remainders[(k / 2) as usize] % 2 != 0 {
            return false;
        }

        true
    }
}