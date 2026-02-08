impl Solution {
    pub fn third_max(nums: Vec<i32>) -> i32 {
        let mut max1: Option<i32> = None;
        let mut max2: Option<i32> = None;
        let mut max3: Option<i32> = None;

        for num in nums {
            if let Some(m1) = max1 {
                if num == m1 {
                    continue;
                }
            }
            if let Some(m2) = max2 {
                if num == m2 {
                    continue;
                }
            }
            if let Some(m3) = max3 {
                if num == m3 {
                    continue;
                }
            }

            if max1.is_none() || num > max1.unwrap() {
                max3 = max2;
                max2 = max1;
                max1 = Some(num);
            } else if max2.is_none() || num > max2.unwrap() {
                max3 = max2;
                max2 = Some(num);
            } else if max3.is_none() || num > max3.unwrap() {
                max3 = Some(num);
            }
        }

        if let Some(m3_val) = max3 {
            m3_val
        } else {
            max1.unwrap()
        }
    }
}