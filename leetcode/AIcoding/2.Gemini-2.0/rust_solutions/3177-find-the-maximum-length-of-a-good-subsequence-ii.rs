impl Solution {
    pub fn get_max_len(nums: Vec<i32>, k: i32) -> i32 {
        let mut tails: Vec<i32> = Vec::new();
        for num in nums {
            if tails.is_empty() || num > *tails.last().unwrap() {
                tails.push(num);
            } else {
                let mut l = 0;
                let mut r = tails.len() - 1;
                while l <= r {
                    let mid = l + (r - l) / 2;
                    if tails[mid] < num {
                        l = mid + 1;
                    } else {
                        r = mid - 1;
                    }
                }
                tails[l] = num;
            }
        }

        let mut ans = 0;
        let n = tails.len();

        for i in 0..n {
            if tails[i] <= k {
                ans += 1;
            }
        }

        ans as i32
    }
}