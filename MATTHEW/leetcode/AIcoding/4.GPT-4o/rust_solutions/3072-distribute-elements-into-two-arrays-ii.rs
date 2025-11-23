impl Solution {
    pub fn distribute_elements(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let n = nums.len() / 2;
        let mut counts = vec![0; 10001];
        for &num in &nums {
            counts[num as usize] += 1;
        }
        let mut ans1 = Vec::new();
        let mut ans2 = Vec::new();

        for num in 0..counts.len() {
            while counts[num] > 0 && (ans1.len() < n || ans2.len() < n) {
                if ans1.len() < n {
                    ans1.push(num as i32);
                } else {
                    ans2.push(num as i32);
                }
                counts[num] -= 1;
            }
        }
        vec![ans1, ans2]
    }
}