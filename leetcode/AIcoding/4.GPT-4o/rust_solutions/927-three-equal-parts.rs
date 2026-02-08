pub struct Solution;

impl Solution {
    pub fn three_equal_parts(arr: Vec<i32>) -> Vec<i32> {
        let total_ones = arr.iter().filter(|&&x| x == 1).count();
        if total_ones % 3 != 0 {
            return vec![-1, -1];
        }
        if total_ones == 0 {
            return vec![0, 2];
        }

        let ones_per_part = total_ones / 3;
        let mut first = 0;
        let mut second = 0;
        let mut third = 0;
        let mut count = 0;

        for (i, &num) in arr.iter().enumerate() {
            if num == 1 {
                count += 1;
                if count == 1 {
                    first = i;
                } else if count == ones_per_part + 1 {
                    second = i;
                } else if count == 2 * ones_per_part + 1 {
                    third = i;
                }
            }
        }

        let mut end1 = first;
        let mut end2 = second;
        let mut end3 = third;

        while end3 < arr.len() && arr[end1] == arr[end2] && arr[end1] == arr[end3] {
            end1 += 1;
            end2 += 1;
            end3 += 1;
        }

        if end3 == arr.len() {
            return vec![first + (end1 - first), second + (end2 - second)];
        }

        vec![-1, -1]
    }
}