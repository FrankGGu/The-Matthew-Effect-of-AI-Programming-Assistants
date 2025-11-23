impl Solution {
    pub fn majority_element(nums: Vec<i32>) -> Vec<i32> {
        if nums.is_empty() {
            return Vec::new();
        }

        let mut cand1 = 0;
        let mut count1 = 0;
        let mut cand2 = 0;
        let mut count2 = 0;

        for &num in &nums {
            if num == cand1 {
                count1 += 1;
            } else if num == cand2 {
                count2 += 1;
            } else if count1 == 0 {
                cand1 = num;
                count1 = 1;
            } else if count2 == 0 {
                cand2 = num;
                count2 = 1;
            } else {
                count1 -= 1;
                count2 -= 1;
            }
        }

        count1 = 0;
        count2 = 0;
        for &num in &nums {
            if num == cand1 {
                count1 += 1;
            } else if num == cand2 {
                count2 += 1;
            }
        }

        let mut result = Vec::new();
        let n = nums.len();
        let threshold = n / 3;

        if count1 > threshold {
            result.push(cand1);
        }
        if count2 > threshold && cand1 != cand2 {
            result.push(cand2);
        }

        result
    }
}