impl Solution {
    pub fn count_beautiful_pairs(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            let first = nums[i].to_string().chars().next().unwrap().to_digit(10).unwrap() as i32;
            for j in i + 1..n {
                let last = nums[j] % 10;
                if gcd(first, last) == 1 {
                    count += 1;
                }
            }
        }
        count
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}