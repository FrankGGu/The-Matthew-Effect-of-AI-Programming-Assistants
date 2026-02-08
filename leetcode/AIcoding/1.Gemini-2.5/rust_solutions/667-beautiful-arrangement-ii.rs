struct Solution;

impl Solution {
    pub fn construct_array(n: i32, k: i32) -> Vec<i32> {
        let mut ans = Vec::with_capacity(n as usize);
        let mut low = 1;
        let mut high = k + 1;

        for i in 0..=k {
            if i % 2 == 0 {
                ans.push(low);
                low += 1;
            } else {
                ans.push(high);
                high -= 1;
            }
        }

        for i in (k + 2)..=n {
            ans.push(i);
        }

        ans
    }
}