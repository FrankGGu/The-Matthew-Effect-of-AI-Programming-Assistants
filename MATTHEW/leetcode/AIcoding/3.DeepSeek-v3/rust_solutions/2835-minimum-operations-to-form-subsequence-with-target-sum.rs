impl Solution {
    pub fn min_operations(nums: Vec<i32>, target: i32) -> i32 {
        let mut target = target as i64;
        let mut sum = 0i64;
        let mut freq = vec![0; 32];

        for &num in nums.iter() {
            sum += num as i64;
            freq[num.trailing_zeros() as usize] += 1;
        }

        if sum < target {
            return -1;
        }

        let mut res = 0;
        let mut i = 0;

        while i < 32 {
            if (target >> i) & 1 == 1 {
                if freq[i] > 0 {
                    freq[i] -= 1;
                } else {
                    let mut j = i + 1;
                    while j < 32 && freq[j] == 0 {
                        j += 1;
                    }
                    if j == 32 {
                        return -1;
                    }
                    freq[j] -= 1;
                    res += j - i;
                    for k in i..j {
                        freq[k] += 1;
                    }
                }
            }
            if i + 1 < 32 {
                freq[i + 1] += freq[i] / 2;
            }
            i += 1;
        }

        res as i32
    }
}