impl Solution {
    pub fn find_best_value(arr: Vec<i32>, target: i32) -> i32 {
        let max_arr_val = *arr.iter().max().unwrap();

        let mut l = 0;
        let mut r = max_arr_val;
        let mut v_upper = max_arr_val; 

        while l <= r {
            let m = l + (r - l) / 2;
            let current_sum = Self::calculate_sum(&arr, m);

            if current_sum >= target {
                v_upper = m;
                r = m - 1;
            } else {
                l = m + 1;
            }
        }

        let sum_upper = Self::calculate_sum(&arr, v_upper);
        let diff_upper = (sum_upper - target).abs();

        let v_lower = v_upper - 1;
        let sum_lower = Self::calculate_sum(&arr, v_lower);
        let diff_lower = (sum_lower - target).abs();

        if diff_lower <= diff_upper {
            v_lower
        } else {
            v_upper
        }
    }

    fn calculate_sum(arr: &[i32], value: i32) -> i32 {
        let mut current_sum = 0;
        for &x in arr {
            current_sum += x.min(value);
        }
        current_sum
    }
}