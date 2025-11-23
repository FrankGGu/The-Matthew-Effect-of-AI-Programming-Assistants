impl Solution {
    pub fn sort_jumbled(mapping: Vec<i32>, nums: Vec<i32>) -> Vec<i32> {
        let mut mapped_nums: Vec<(i32, i32)> = nums.iter()
            .map(|&num| {
                let mut mapped_num = 0;
                let mut base = 1;
                let mut n = num;
                while n > 0 {
                    let digit = (n % 10) as usize;
                    mapped_num = mapped_num + mapping[digit] * base;
                    base *= 10;
                    n /= 10;
                }
                (mapped_num, num)
            })
            .collect();

        mapped_nums.sort_by_key(|&(mapped, _)| mapped);

        mapped_nums.iter().map(|&(_, original)| original).collect()
    }
}