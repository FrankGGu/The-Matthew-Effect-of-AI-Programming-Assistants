impl Solution {
    pub fn minimum_swaps(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut indices: Vec<usize> = (0..n).collect();
        indices.sort_by_key(|&i| Self::digit_sum(nums[i]));

        let mut visited = vec![false; n];
        let mut swaps = 0;

        for i in 0..n {
            if visited[i] || indices[i] == i {
                continue;
            }

            let mut cycle_size = 0;
            let mut j = i;
            while !visited[j] {
                visited[j] = true;
                j = indices[j];
                cycle_size += 1;
            }

            swaps += cycle_size - 1;
        }

        swaps as i32
    }

    fn digit_sum(num: i32) -> i32 {
        let mut sum = 0;
        let mut n = num;
        while n > 0 {
            sum += n % 10;
            n /= 10;
        }
        sum
    }
}