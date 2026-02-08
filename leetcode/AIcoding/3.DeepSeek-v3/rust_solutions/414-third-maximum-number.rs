impl Solution {
    pub fn third_max(nums: Vec<i32>) -> i32 {
        let mut max1 = None;
        let mut max2 = None;
        let mut max3 = None;

        for &num in nums.iter() {
            if Some(num) == max1 || Some(num) == max2 || Some(num) == max3 {
                continue;
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

        if max3.is_some() {
            max3.unwrap()
        } else {
            max1.unwrap()
        }
    }
}