impl Solution {
    pub fn min_equal_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let mut sum1: i64 = 0;
        let mut zero_count1: i64 = 0;
        for &num in &nums1 {
            if num == 0 {
                zero_count1 += 1;
            }
            sum1 += num as i64;
        }

        let mut sum2: i64 = 0;
        let mut zero_count2: i64 = 0;
        for &num in &nums2 {
            if num == 0 {
                zero_count2 += 1;
            }
            sum2 += num as i64;
        }

        let min_possible_sum1 = sum1 + zero_count1;
        let min_possible_sum2 = sum2 + zero_count2;

        if zero_count1 == 0 && zero_count2 == 0 {
            if sum1 == sum2 {
                return sum1;
            } else {
                return -1;
            }
        } else if zero_count1 == 0 { // zero_count2 > 0 implied
            if sum1 >= min_possible_sum2 {
                return sum1;
            } else {
                return -1;
            }
        } else if zero_count2 == 0 { // zero_count1 > 0 implied
            if sum2 >= min_possible_sum1 {
                return sum2;
            } else {
                return -1;
            }
        } else { // both zero_count1 > 0 and zero_count2 > 0
            return min_possible_sum1.max(min_possible_sum2);
        }
    }
}