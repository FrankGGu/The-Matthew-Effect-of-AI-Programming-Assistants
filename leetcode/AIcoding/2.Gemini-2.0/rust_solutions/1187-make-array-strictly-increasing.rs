use std::collections::BTreeSet;

impl Solution {
    pub fn make_array_strictly_increasing(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let mut sorted_arr2: BTreeSet<i32> = arr2.into_iter().collect();
        let n = arr1.len();
        let mut dp: std::collections::HashMap<(usize, i32), i32> = std::collections::HashMap::new();

        fn solve(
            i: usize,
            prev: i32,
            arr1: &Vec<i32>,
            sorted_arr2: &BTreeSet<i32>,
            dp: &mut std::collections::HashMap<(usize, i32), i32>,
        ) -> i32 {
            if i == arr1.len() {
                return 0;
            }

            if let Some(&cost) = dp.get(&(i, prev)) {
                return cost;
            }

            let mut ans = i32::MAX;

            if arr1[i] > prev {
                ans = solve(i + 1, arr1[i], arr1, sorted_arr2, dp);
            }

            if let Some(&next_val) = sorted_arr2.range(prev + 1..).next() {
                let mut new_sorted_arr2 = sorted_arr2.clone();
                new_sorted_arr2.remove(&next_val);
                let temp = solve(i + 1, next_val, arr1, sorted_arr2, dp);

                if temp != i32::MAX {
                    ans = ans.min(1 + temp);
                }
            }
            dp.insert((i, prev), ans);
            ans
        }

        let res = solve(0, i32::MIN, &arr1, &sorted_arr2, &mut dp);

        if res == i32::MAX {
            -1
        } else {
            res
        }
    }
}