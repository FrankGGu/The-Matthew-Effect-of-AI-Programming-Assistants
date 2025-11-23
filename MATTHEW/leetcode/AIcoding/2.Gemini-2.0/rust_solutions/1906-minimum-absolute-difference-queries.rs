impl Solution {
    pub fn min_difference(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut positions: Vec<Vec<usize>> = vec![vec![]; 101];
        for i in 0..n {
            positions[nums[i] as usize].push(i);
        }

        let mut result = Vec::new();
        for query in &queries {
            let left = query[0] as usize;
            let right = query[1] as usize;

            let mut last = -1;
            let mut min_diff = i32::MAX;

            for v in 1..=100 {
                let pos = &positions[v];
                let l = pos.binary_search(&left);
                let r = pos.binary_search(&right);

                let mut found = false;

                match l {
                    Ok(_) => found = true,
                    Err(idx) => {
                        if idx < pos.len() && pos[idx] <= right {
                            found = true;
                        }
                    }
                }

                if found {
                    if last != -1 {
                        min_diff = min_diff.min(v as i32 - last);
                    }
                    last = v as i32;
                }
            }

            if min_diff == i32::MAX {
                result.push(-1);
            } else {
                result.push(min_diff);
            }
        }

        result
    }
}