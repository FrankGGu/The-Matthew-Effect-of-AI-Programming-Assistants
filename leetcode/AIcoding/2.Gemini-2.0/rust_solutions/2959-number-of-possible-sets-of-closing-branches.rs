impl Solution {
    pub fn number_of_possible_sets_of_closing_branches(n: i32, roads: Vec<Vec<i32>>, cost: i32) -> i32 {
        let n = n as usize;
        let mut ans = i32::MAX;

        for mask in 0..(1 << n) {
            let mut current_cost = 0;
            let mut is_valid = true;

            for road in &roads {
                let u = road[0] as usize - 1;
                let v = road[1] as usize - 1;

                if (mask & (1 << u) != 0) && (mask & (1 << v) != 0) {
                    current_cost += cost;
                } else if (mask & (1 << u) == 0) && (mask & (1 << v) == 0) {
                    continue;
                } else {
                    is_valid = false;
                    break;
                }
            }

            if is_valid {
                let closed_count = mask.count_ones() as i32;
                ans = ans.min(current_cost + closed_count);
            }
        }

        ans
    }
}