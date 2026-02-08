impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut odd_count = 0;
        let mut even_count = 1;
        let mut sum = 0;

        for &num in arr.iter() {
            sum += num;
            if sum % 2 != 0 {
                count += even_count;
                odd_count += 1;
            } else {
                count += odd_count;
                even_count += 1;
            }
        }

        count
    }
}