impl Solution {
    pub fn sort_jumbled(mapping: Vec<i32>, nums: Vec<i32>) -> Vec<i32> {
        let mut nums_with_mapped: Vec<(i32, i32)> = nums.iter().map(|&num| {
            let mapped = if num == 0 {
                mapping[0]
            } else {
                let mut n = num;
                let mut res = 0;
                let mut base = 1;
                while n != 0 {
                    let digit = (n % 10) as usize;
                    res += mapping[digit] * base;
                    base *= 10;
                    n /= 10;
                }
                res
            };
            (mapped, num)
        }).collect();

        nums_with_mapped.sort_by_key(|&(mapped, _)| mapped);
        nums_with_mapped.into_iter().map(|(_, num)| num).collect()
    }
}