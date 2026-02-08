impl Solution {
    pub fn length_of_lis(nums: Vec<i32>) -> i32 {
        let mut tails = Vec::new();
        for num in nums {
            if tails.is_empty() || num > *tails.last().unwrap() {
                tails.push(num);
            } else {
                let mut left = 0;
                let mut right = tails.len() - 1;
                while left < right {
                    let mid = left + (right - left) / 2;
                    if tails[mid] < num {
                        left = mid + 1;
                    } else {
                        right = mid;
                    }
                }
                tails[left] = num;
            }
        }
        tails.len() as i32
    }
}