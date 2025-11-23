impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn third_max(nums: Vec<i32>) -> i32 {
        let mut first = None;
        let mut second = None;
        let mut third = None;

        for &num in &nums {
            match first {
                None => first = Some(num),
                Some(f) => match f.cmp(&num) {
                    Ordering::Less => {
                        third = second;
                        second = first;
                        first = Some(num);
                    }
                    Ordering::Equal => {}
                    Ordering::Greater => {
                        match second {
                            None => second = Some(num),
                            Some(s) => {
                                if s < num {
                                    third = second;
                                    second = Some(num);
                                }
                            }
                        }
                    }
                },
            }
        }

        match third {
            Some(t) => t,
            None => first.unwrap(),
        }
    }
}
}