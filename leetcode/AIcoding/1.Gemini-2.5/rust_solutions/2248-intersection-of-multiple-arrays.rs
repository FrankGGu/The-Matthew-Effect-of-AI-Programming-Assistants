impl Solution {
    pub fn intersection(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut freq = [0; 1001];

        for arr in nums {
            for num in arr {
                freq[num as usize] += 1;
            }
        }

        let mut result = Vec::new();
        for i in 1..=1000 {
            if freq[i] == n {
                result.push(i as i32);
            }
        }

        result
    }
}