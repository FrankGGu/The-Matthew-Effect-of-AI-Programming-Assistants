impl Solution {
    pub fn sum_of_floored_pairs(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count: Vec<i64> = vec![0; 200001];
        let mut freq: Vec<i64> = vec![0; 200001];
        for &num in &nums {
            freq[num as usize] += 1;
        }
        for i in 1..=200000 {
            count[i] = count[i - 1] + freq[i];
        }
        let mut ans: i64 = 0;
        for &num in &nums {
            let mut k: i32 = 1;
            while k <= num {
                let left = num / (k + 1) + 1;
                let right = num / k;
                if right >= 0 && left >= 0 && (right as usize) < count.len() && (left as usize) <= count.len() {
                    let c = count[right as usize] - count[left.max(0) as usize - 1];
                    ans += c * (k as i64);
                }
                k = num / (num / k + 1);
            }
        }
        (ans % 1000000007) as i32
    }
}