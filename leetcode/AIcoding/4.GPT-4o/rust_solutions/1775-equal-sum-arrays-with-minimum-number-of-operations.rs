impl Solution {
    pub fn min_operations(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let sum1: i32 = nums1.iter().sum();
        let sum2: i32 = nums2.iter().sum();

        if sum1 == sum2 {
            return 0;
        }

        let (larger, smaller) = if sum1 > sum2 { (sum1, sum2) } else { (sum2, sum1) };
        let diff = larger - smaller;

        if diff == 0 {
            return 0;
        }

        let mut count = vec![0; 7];
        for &num in &nums1 {
            count[(num - 1).min(6) as usize] += 1;
        }
        for &num in &nums2 {
            count[(7 - num).min(6) as usize] += 1;
        }

        let mut operations = 0;
        for i in (1..=6).rev() {
            while count[i] > 0 && diff > 0 {
                operations += 1;
                diff -= i;
                count[i] -= 1;
            }
            if diff <= 0 {
                return operations;
            }
        }

        -1
    }
}