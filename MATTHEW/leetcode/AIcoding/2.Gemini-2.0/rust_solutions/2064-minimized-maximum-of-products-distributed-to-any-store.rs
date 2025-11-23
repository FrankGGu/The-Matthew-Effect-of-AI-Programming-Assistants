impl Solution {
    pub fn minimized_maximum(n: i32, quantities: Vec<i32>) -> i32 {
        let mut left = 1;
        let mut right = *quantities.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            let mut count = 0;
            for &quantity in &quantities {
                count += (quantity + mid - 1) / mid;
            }

            if count <= n {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}