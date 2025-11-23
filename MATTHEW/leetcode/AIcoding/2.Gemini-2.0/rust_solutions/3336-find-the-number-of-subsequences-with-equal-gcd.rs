impl Solution {
    pub fn gcd(mut a: i32, mut b: i32) -> i32 {
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    }

    pub fn count_different_subsequence_gcds(nums: Vec<i32>) -> i32 {
        let max_num = *nums.iter().max().unwrap() as usize;
        let mut present = vec![false; max_num + 1];
        for &num in &nums {
            present[num as usize] = true;
        }

        let mut count = 0;
        for i in 1..=max_num {
            let mut g = 0;
            for j in (i..=max_num).step_by(i) {
                if present[j] {
                    if g == 0 {
                        g = j as i32;
                    } else {
                        g = Self::gcd(g, j as i32);
                    }
                }
            }
            if g == i as i32 {
                count += 1;
            }
        }

        count
    }
}