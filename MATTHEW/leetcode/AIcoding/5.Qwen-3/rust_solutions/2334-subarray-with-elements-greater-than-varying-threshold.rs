impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn is_subarray(arr: Vec<i32>, sub: Vec<i32>) -> bool {
        let len = arr.len();
        let sub_len = sub.len();

        if sub_len == 0 {
            return true;
        }

        if len < sub_len {
            return false;
        }

        for i in 0..=len - sub_len {
            let mut match_found = true;
            for j in 0..sub_len {
                if arr[i + j] != sub[j] {
                    match_found = false;
                    break;
                }
            }
            if match_found {
                return true;
            }
        }

        false
    }

    pub fn valid SubarrayWithElementsGreaterThanVaryingThreshold(arr: Vec<i32>, threshold: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        let m = threshold.len();

        for i in 0..n {
            let mut current = vec![];
            for j in i..n {
                current.push(arr[j]);
                let mut valid = true;
                for k in 0..current.len() {
                    if current[k] <= threshold[k] {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    return current;
                }
            }
        }

        vec![]
    }
}
}