impl Solution {
    pub fn sum_of_number_and_reverse(num: i32, k: i32) -> i32 {
        for i in 0..=num {
            if i % 10 == k {
                let reversed = i.to_string().chars().rev().collect::<String>().parse::<i32>().unwrap();
                if i + reversed == num {
                    return 1;
                }
            }
        }
        0
    }
}