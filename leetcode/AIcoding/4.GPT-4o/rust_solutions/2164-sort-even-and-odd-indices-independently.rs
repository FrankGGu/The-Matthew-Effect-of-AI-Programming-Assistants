impl Solution {
    pub fn sort_even_odd(nums: Vec<i32>) -> Vec<i32> {
        let mut even: Vec<i32> = nums.iter().enumerate()
            .filter_map(|(i, &x)| if i % 2 == 0 { Some(x) } else { None })
            .collect();
        let mut odd: Vec<i32> = nums.iter().enumerate()
            .filter_map(|(i, &x)| if i % 2 != 0 { Some(x) } else { None })
            .collect();

        even.sort();
        odd.sort_by(|a, b| b.cmp(a));

        let mut result = vec![0; nums.len()];
        let mut even_index = 0;
        let mut odd_index = 0;

        for i in 0..nums.len() {
            if i % 2 == 0 {
                result[i] = even[even_index];
                even_index += 1;
            } else {
                result[i] = odd[odd_index];
                odd_index += 1;
            }
        }

        result
    }
}