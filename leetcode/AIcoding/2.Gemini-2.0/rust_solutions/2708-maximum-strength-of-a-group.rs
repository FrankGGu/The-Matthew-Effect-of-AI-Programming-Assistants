impl Solution {
    pub fn max_strength(nums: Vec<i32>) -> i64 {
        let mut negatives = Vec::new();
        let mut positives = Vec::new();
        let mut zeros = 0;
        for num in nums {
            if num < 0 {
                negatives.push(num);
            } else if num > 0 {
                positives.push(num);
            } else {
                zeros += 1;
            }
        }
        negatives.sort();
        let mut ans: i64 = 1;
        if negatives.len() % 2 == 0 {
            for i in 0..negatives.len() {
                ans *= negatives[i] as i64;
            }
        } else {
            if negatives.len() == 1 && positives.is_empty() && zeros > 0 {
                return 0;
            }
            for i in 0..negatives.len() - 1 {
                ans *= negatives[i] as i64;
            }
        }
        for i in 0..positives.len() {
            ans *= positives[i] as i64;
        }
        if ans == 1 && negatives.is_empty() && positives.is_empty() && zeros > 0 {
            return 0;
        }
        if ans == 1 && !negatives.is_empty() && positives.is_empty() && zeros == 0 {
            if negatives.len() == 1 {
                return negatives[0] as i64;
            } else {
                return ans;
            }
        }
        ans
    }
}